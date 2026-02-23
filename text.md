1. TileLayer: 
Digital maps are just a bunch of small square images (called tiles) placed side-by-side. Right now, your app is pulling these images from the internet. Later, we will write a script to download these square images straight to your phone's memory so they load even when you turn off your Wi-Fi and mobile data.

.. ... Even if the cellular towers in Noida completely go down, your app will still know exactly where the local safe zones are.




2. Connect it to Your App
   Now go back to your main.dart file. We need to tell the app to load this database as soon as it opens.

At the very top of main.dart, add this import:

Dart
```import 'database_helper.dart';```
Then, find the _MapScreenState section. Add an initState block right inside it, like this:

Dart
```
class _MapScreenState extends State<MapScreen> {

@override
void initState() {
super.initState();
_loadOfflineData();
}

// This grabs the data quietly in the background when the app opens
void _loadOfflineData() async {
final zones = await DatabaseHelper.getSafeZones();
print("Offline database loaded! Found ${zones.length} safe zones.");
for (var zone in zones) {
print(zone['name']); // This will print the locations in your terminal
}
}

@override
Widget build(BuildContext context) {
// ... (keep the rest of your build code exactly the same)
```



1. Add Android Permissions
   Open your project folder and go to ```android -> app -> src -> main -> AndroidManifest.xml.```
   Add these two lines exactly below the <manifest> tag but above the <application> tag:

XML
```
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```



Why the "Navigate Here" button didn't work
In Flutter, pop-up dialogs and slide-up menus live in a different "layer" than your main screen. When you called setState inside the pop-up, it updated the data in the background, but the map didn't visually refresh or move the camera to show you the line.

To fix this, we need to add a MapController (which tells the map camera to physically move to your location) and properly close the pop-up layers before drawing the line.







```
Event-Driven Background Synchronization.
In professional apps (like WhatsApp or Google Maps), when your phone reconnects to the internet, the app doesn't interrupt you with pop-ups. It uses an "Event Listener" to silently detect the network change, fetches the new data in the background, and seamlessly updates the UI.

```



### SQLite types:
```
TEXT
REAL (float)
INTEGER
```