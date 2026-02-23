import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Your custom files
import 'api_sync.dart';
import 'database.dart';
import 'offline_util.dart';
import 'first_aid.dart'; // Q&A database!

void main() {
  runApp(const RescueZeroApp());
}

class RescueZeroApp extends StatelessWidget {
  const RescueZeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rescue Zero',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Navigation & UI State
  int _bottomNavIndex = 0;
  bool isTrueBlackMode = false; // FEATURE 3: Battery Saver Mode

  // Map States
  LatLng? userLocation;
  List<LatLng> emergencyRoute = [];
  bool isOfflineMode = false;
  String? offlineMapPath;
  final MapController _mapController = MapController();
  double _searchRadius = 10.0;
  List<Map<String, dynamic>> allSafeZones = [];
  StreamSubscription? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _loadOfflineData();
    _getOfflinePath();
    _getInitialLocation();
    _startNetworkListener();
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  void _startNetworkListener() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
      bool isOnline = false;
      if (result is List<ConnectivityResult>) {
        isOnline = result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi);
      } else if (result is ConnectivityResult) {
        isOnline = result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
      }
      if (isOnline && userLocation != null && !isOfflineMode) {
        _silentBackgroundSync();
      }
    });
  }

  void _silentBackgroundSync() async {
    print("Network restored: Starting silent background sync...");
    await ApiSync.fetchAndSaveLocalData(
        userLocation!.latitude,
        userLocation!.longitude,
        50000
    );
    _loadOfflineData();
  }

  void _getInitialLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (mounted) {
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
      });
      _mapController.move(userLocation!, 13.0);

      final zones = await DatabaseHelper.getSafeZones();
      if (zones.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("First launch: Downloading 50km emergency radius..."))
        );

        String result = await ApiSync.fetchAndSaveLocalData(
            position.latitude,
            position.longitude,
            50000
        );

        _loadOfflineData();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
        }
      }
    }
  }

  void _loadOfflineData() async {
    final zones = await DatabaseHelper.getSafeZones();
    if (mounted) {
      setState(() {
        allSafeZones = zones;
      });
    }
  }

  Future<void> _getOfflinePath() async {
    final dir = await getApplicationDocumentsDirectory();
    setState(() {
      offlineMapPath = "${dir.path}/offline_tiles";
    });
  }

  void _showSafeZonesList() async {
    if (userLocation == null) return;

    List<Map<String, dynamic>> zonesWithDistance = [];
    for (var zone in allSafeZones) {
      double distanceInMeters = Geolocator.distanceBetween(
          userLocation!.latitude, userLocation!.longitude, zone['lat'], zone['lng']);

      double distanceKm = distanceInMeters / 1000;

      if (distanceKm <= _searchRadius) {
        Map<String, dynamic> mutableZone = Map<String, dynamic>.from(zone);
        mutableZone['distance'] = distanceInMeters;
        zonesWithDistance.add(mutableZone);
      }
    }

    if (zonesWithDistance.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No safe zones found within ${_searchRadius.toInt()} km.", style: const TextStyle(color: Colors.white))),
      );
      return;
    }

    zonesWithDistance.sort((a, b) => a['distance'].compareTo(b['distance']));

    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: isTrueBlackMode ? Colors.grey[900] : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return ListView.builder(
          itemCount: zonesWithDistance.length,
          itemBuilder: (context, index) {
            var z = zonesWithDistance[index];
            double distanceKm = z['distance'] / 1000;
            Color textColor = isTrueBlackMode ? Colors.white : Colors.black;

            return ListTile(
              leading: Icon(
                z['type'] == 'Hospital' ? Icons.local_hospital : Icons.local_police,
                color: z['type'] == 'Hospital' ? Colors.red : Colors.blue,
                size: 40,
              ),
              title: Text(z['name'], style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
              subtitle: Text('${distanceKm.toStringAsFixed(2)} km away • ${z['phone']}', style: TextStyle(color: isTrueBlackMode ? Colors.grey[400] : Colors.grey[700])),
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: textColor),
              onTap: () {
                _showZoneDetails(z, userLocation!);
              },
            );
          },
        );
      },
    );
  }

  void _showZoneDetails(Map<String, dynamic> zone, LatLng userLoc) {
    double distanceKm = (Geolocator.distanceBetween(
        userLoc.latitude, userLoc.longitude, zone['lat'], zone['lng'])) / 1000;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isTrueBlackMode ? Colors.grey[900] : Colors.white,
          title: Text(zone['name'], style: TextStyle(color: isTrueBlackMode ? Colors.white : Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Type: ${zone['type']}', style: TextStyle(fontWeight: FontWeight.bold, color: isTrueBlackMode ? Colors.white : Colors.black)),
              const SizedBox(height: 10),
              Text('📞 Emergency: ${zone['phone']}', style: TextStyle(color: isTrueBlackMode ? Colors.grey[300] : Colors.black87)),
              Text('🕒 Hours: ${zone['hours']}', style: TextStyle(color: isTrueBlackMode ? Colors.grey[300] : Colors.black87)),
              Text('📍 Distance: ${distanceKm.toStringAsFixed(2)} km', style: TextStyle(color: isTrueBlackMode ? Colors.grey[300] : Colors.black87)),
              const SizedBox(height: 10),
              Text('Info: ${zone['details']}', style: TextStyle(color: isTrueBlackMode ? Colors.grey[300] : Colors.black87)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: isTrueBlackMode ? Colors.grey[400] : Colors.blue)),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.pop(context);
                if (Navigator.canPop(context)) Navigator.pop(context);

                setState(() {
                  emergencyRoute = [userLoc, LatLng(zone['lat'], zone['lng'])];
                });

                _mapController.move(userLoc, 14.0);
              },
              icon: const Icon(Icons.navigation, color: Colors.white),
              label: const Text('Navigate', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _showMyLocationInfo() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String exactCoordinates = "${position.latitude}, ${position.longitude}";
    String address = "Address unavailable (No Internet)";

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
      }
    } catch (e) {
      print("Offline mode: Skipping street address.");
    }

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isTrueBlackMode ? Colors.grey[900] : Colors.white,
          title: Text('📍 My Current Location', style: TextStyle(color: isTrueBlackMode ? Colors.white : Colors.black)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Coordinates:', style: TextStyle(fontWeight: FontWeight.bold, color: isTrueBlackMode ? Colors.grey[400] : Colors.grey)),
              Text(exactCoordinates, style: TextStyle(fontSize: 16, color: isTrueBlackMode ? Colors.white : Colors.black)),
              const SizedBox(height: 15),
              Text('Nearest Address:', style: TextStyle(fontWeight: FontWeight.bold, color: isTrueBlackMode ? Colors.grey[400] : Colors.grey)),
              Text(address, style: TextStyle(fontSize: 16, color: isTrueBlackMode ? Colors.white : Colors.black)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close', style: TextStyle(color: isTrueBlackMode ? Colors.grey[400] : Colors.blue)),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                Share.share(
                    '🚨 EMERGENCY: I need help. \n\nMy location is: $address \n\nExact GPS Coordinates: $exactCoordinates \n\nGoogle Maps Link: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}'
                );
              },
              icon: const Icon(Icons.share, color: Colors.white),
              label: const Text('Share Location', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    _mapController.move(LatLng(position.latitude, position.longitude), 16.0);
  }

  // --- UI BUILDER FOR THE MAP TAB ---
  Widget _buildMapTab() {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: const MapOptions(
            initialCenter: LatLng(28.5355, 77.3910),
            initialZoom: 13.0,
          ),
          children: [
            // FEATURE 3: ColorMatrix perfectly inverts map colors for True Black mode
            ColorFiltered(
              colorFilter: isTrueBlackMode
                  ? const ColorFilter.matrix([
                -1,  0,  0, 0, 255,
                0, -1,  0, 0, 255,
                0,  0, -1, 0, 255,
                0,  0,  0, 1,   0,
              ])
                  : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
              child: TileLayer(
                urlTemplate: isOfflineMode
                    ? '$offlineMapPath/{z}/{x}/{y}.png'
                    : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.rescue_zero',
                tileProvider: isOfflineMode
                    ? FileTileProvider()
                    : NetworkTileProvider(),
              ),
            ),
            if (emergencyRoute.isNotEmpty)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: emergencyRoute,
                    color: Colors.blue,
                    strokeWidth: 5.0,
                  ),
                ],
              ),
            if (userLocation != null)
              ///user location radius
              CircleLayer(
                circles: [
                  CircleMarker(
                    point: userLocation!,
                    color: Colors.yellowAccent.withAlpha(65),
                    borderColor: Colors.blue,
                    borderStrokeWidth: 2.0,
                    useRadiusInMeter: true,
                    radius: _searchRadius * 1000,
                  ),
                ],
              ),
            MarkerLayer(
              markers: [
                if (userLocation != null)
                  Marker(
                    point: userLocation!,
                    width: 40, height: 40,
                    child: const Icon(Icons.person_pin_circle, color: Colors.blue, size: 40),
                  ),
                if (userLocation != null)
                  ...allSafeZones.where((zone) {
                    double dist = Geolocator.distanceBetween(
                        userLocation!.latitude, userLocation!.longitude, zone['lat'], zone['lng']);
                    return dist <= (_searchRadius * 1000);
                  }).map((zone) {
                    return Marker(
                      point: LatLng(zone['lat'], zone['lng']),
                      width: 40, height: 40,
                      child: GestureDetector(
                        onTap: () => _showZoneDetails(zone, userLocation!),
                        child: Icon(
                          zone['type'] == 'Hospital' ? Icons.local_hospital : Icons.local_police,
                          color: zone['type'] == 'Hospital' ? Colors.red : Colors.blue,
                          size: 35,
                        ),
                      ),
                    );
                  }).toList(),
              ],
            ),
          ],
        ),


        /// SYNC -BTN
        Positioned(
          top: 20,
          right: 20,
          child: FloatingActionButton(
            heroTag: "syncDataBtn",
            backgroundColor: isTrueBlackMode ? Colors.grey[900] : Colors.white,
            onPressed: () async {
              if (userLocation == null) return;
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Refreshing 50km database...", style: TextStyle(color: isTrueBlackMode ? Colors.black : Colors.white)))
              );
              String result = await ApiSync.fetchAndSaveLocalData(
                  userLocation!.latitude,
                  userLocation!.longitude,
                  50000
              );
              _loadOfflineData();
              if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
            },
            child: Icon(Icons.sync, color: isTrueBlackMode ? Colors.blue[300] : Colors.blue),
          ),
        ),


        /// DOWNLOAD -BTN
        Positioned(
          top: 20,
          left: 20,
          child: FloatingActionButton(
            heroTag: "downloadBtn",
            backgroundColor: isTrueBlackMode ? Colors.grey[900] : Colors.white,
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Starting Download...")));
              String result = await OfflineUtil.downloadTiles();
              if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
            },
            child: Icon(Icons.download, color: isTrueBlackMode ? Colors.blue[300] : Colors.blue),
          ),
        ),


        /// WHERE AM I -BtuN
        Positioned(
          bottom: 200,
          right: 20,
          child: FloatingActionButton(
            heroTag: "whereAmI",
            backgroundColor: isTrueBlackMode ? Colors.blue[900] : Colors.blue,
            onPressed: _showMyLocationInfo,
            child: const Icon(Icons.my_location, color: Colors.white),
          ),
        ),


        ///SLIDER
        Positioned(
          bottom: 95,
          left: 20,
          right: 20,
          child: Card(
            elevation: 4,
            color: isTrueBlackMode ? Colors.grey[900]!.withOpacity(0.95) : Colors.white.withOpacity(0.95),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                children: [
                  Text(
                      "Search Radius: ${_searchRadius.toInt()} km",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isTrueBlackMode ? Colors.white : Colors.black)
                  ),
                  Slider(
                    value: _searchRadius,
                    min: 1,
                    max: 50,
                    divisions: 49,
                    activeColor: Colors.purple,
                    inactiveColor: isTrueBlackMode ? Colors.grey[800] : Colors.red[100],
                    label: "${_searchRadius.toInt()} km",
                    onChanged: (val) {
                      setState(() {
                        _searchRadius = val;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        /// SHOW SAFE ZONE -BTN
        Positioned(
          bottom: 30,
          left: 20,
          right: 20,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15),
              backgroundColor: isTrueBlackMode ? Colors.grey[900] : Colors.white,
            ),
            onPressed: _showSafeZonesList,
            icon: Icon(Icons.list, color: isTrueBlackMode ? Colors.cyanAccent[300] : Colors.cyanAccent),
            label: Text(
              'Show Safe Zones List',
              style: TextStyle(color: isTrueBlackMode ? Colors.cyanAccent[200] : Colors.cyanAccent, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isTrueBlackMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
            _bottomNavIndex == 0 ? 'Emergency Map' : 'Survival Guide',
            style: const TextStyle(color: Colors.white)
        ),
        backgroundColor: isTrueBlackMode
            ? Colors.black
            : (isOfflineMode ? Colors.grey[800] : Colors.red[700]),
        actions: [

          // THE BATTERY SAVER TOGGLE
          IconButton(
            icon: Icon(isTrueBlackMode ? Icons.wb_sunny : Icons.nightlight_round),
            color: isTrueBlackMode ? Colors.amber : Colors.white,
            onPressed: () {
              setState(() {
                isTrueBlackMode = !isTrueBlackMode;
              });
            },
          ),

          if (_bottomNavIndex == 0)
            Row(
              children: [
                Text(
                    isOfflineMode ? "Offline" : "Online",
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                ),
                Switch(
                  value: isOfflineMode,
                  activeColor: Colors.green,
                  activeTrackColor: Colors.white,
                  onChanged: (val) {
                    setState(() {
                      isOfflineMode = val;
                    });
                  },
                ),
              ],
            )
        ],
      ),

      body: IndexedStack(
        index: _bottomNavIndex,
        children: [
          _buildMapTab(),
          FirstAidScreen(isTrueBlackMode: isTrueBlackMode), // Passes the theme down!
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        backgroundColor: isTrueBlackMode ? Colors.black : Colors.white,
        selectedItemColor: isTrueBlackMode ? Colors.red[300] : Colors.red[700],
        unselectedItemColor: isTrueBlackMode ? Colors.grey[600] : Colors.grey[400],
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'First Aid',
          ),
        ],
      ),
    );
  }
}

// ==========================================
// FIRST AID & SURVIVAL HUB
// ==========================================
class FirstAidScreen extends StatefulWidget {
  final bool isTrueBlackMode; // Receives the theme from MainScreen

  const FirstAidScreen({super.key, required this.isTrueBlackMode});

  @override
  State<FirstAidScreen> createState() => _FirstAidScreenState();
}

class _FirstAidScreenState extends State<FirstAidScreen> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    Color textColor = widget.isTrueBlackMode ? Colors.white : Colors.black87;
    Color cardColor = widget.isTrueBlackMode ? Colors.grey[900]! : Colors.white;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: widget.isTrueBlackMode ? Colors.grey[850] : Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEnglish ? "Available in Hindi/Hinglish" : "Available in English",
                style: TextStyle(fontWeight: FontWeight.bold, color: widget.isTrueBlackMode ? Colors.grey[400] : Colors.grey),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                onPressed: () {
                  setState(() {
                    isEnglish = !isEnglish;
                  });
                },
                icon: const Icon(Icons.language, color: Colors.white, size: 18),
                label: Text(
                    isEnglish ? "Read in Hinglish" : "Read in English",
                    style: const TextStyle(color: Colors.white)
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          color: widget.isTrueBlackMode ? Colors.orange[900]!.withOpacity(0.3) : Colors.orange[100],
          child: Text(
            "⚠️ Disclaimer: These are emergency first-aid tips. Always seek professional medical help.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: widget.isTrueBlackMode ? Colors.orange[300] : Colors.deepOrange),
          ),
        ),

        Expanded(
          child: ListView.builder(
            itemCount: firstAidList.length,
            itemBuilder: (context, index) {
              final item = firstAidList[index];
              return Card(
                color: cardColor,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                elevation: 2,
                child: ExpansionTile(
                  iconColor: Colors.red,
                  collapsedIconColor: Colors.grey,
                  title: Text(
                    isEnglish ? item['en_q']! : item['hi_q']!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        isEnglish ? item['en_a']! : item['hi_a']!,
                        style: TextStyle(fontSize: 15, height: 1.4, color: widget.isTrueBlackMode ? Colors.grey[300] : Colors.black87),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}