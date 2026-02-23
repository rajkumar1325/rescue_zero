// It fetches nearby emergency places from OpenStreetMap (Overpass API) and stores them locally.

import 'package:dio/dio.dart'; //Used to call REST APIs, Alternative to http package
import 'database.dart';

class ApiSync {
  static Future<String> fetchAndSaveLocalData(double lat, double lng, int radiusInMeters) async {
    final dio = Dio();

    // UPDATED: Use the dynamic radius in the query
    String query = '''
      [out:json][timeout:25];
      (
        node["amenity"="hospital"](around:$radiusInMeters,$lat,$lng);
        node["amenity"="police"](around:$radiusInMeters,$lat,$lng);
      );
      out body;
    ''';


    String url = "https://overpass-api.de/api/interpreter";

    try {
      final response = await dio.post(url, data: query);

      if (response.statusCode == 200) {
        List elements = response.data['elements'];
        if (elements.isEmpty) return "No emergency services found in this area.";

        // 1. Wipe the old database so we don't get duplicates
        await DatabaseHelper.clearAllSafeZones();

        int savedCount = 0;

        // 2. Loop through the JSON response and save valid locations
        for (var element in elements) {
          // Only save it if it actually has a name
          if (element['tags'] != null && element['tags']['name'] != null) {
            String type = element['tags']['amenity'] == 'hospital' ? 'Hospital' : 'Police';
            String name = element['tags']['name'];

            // Not every place on the map has a phone number listed, so we provide a fallback
            String phone = element['tags']['phone'] ?? 'Number unavailable';
            String hours = element['tags']['opening_hours'] ?? 'Hours unavailable';

            await DatabaseHelper.insertSafeZone({
              'name': name,
              'lat': element['lat'],
              'lng': element['lon'],
              'type': type,
              'phone': phone,
              'hours': hours,
              'details': 'Sourced from live OpenStreetMap data.'
            });
            savedCount++;
          }
        }
        return "Successfully synced $savedCount live emergency locations!";
      }
    } catch (e) {
      return "Failed to sync data. Please check your internet connection.";
    }
    return "Unknown error occurred.";
  }
}