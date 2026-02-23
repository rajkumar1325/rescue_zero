import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class OfflineUtil {
  static Point getTileXY(double lat, double lng, int zoom) {
    var n = pow(2.0, zoom);
    var latRad = lat * pi / 180;
    var xtile = (n * ((lng + 180) / 360)).floor();
    var ytile = (n * (1 - (log(tan(latRad) + (1 / cos(latRad))) / pi)) / 2).floor();
    return Point(xtile, ytile);
  }

  static Future<String> downloadTiles() async {
    // 1. Give our downloader a custom ID (User-Agent)
    final dio = Dio(BaseOptions(
      headers: {
        'User-Agent': 'OfflineEmergencyHelperApp/1.0 (StudentProject)'
      },
    ));

    final dir = await getApplicationDocumentsDirectory();
    final String basePath = "${dir.path}/offline_tiles";

    double minLat = 28.516;
    double maxLat = 28.632;
    double minLng = 77.309;
    double maxLng = 77.408;

    int totalDownloaded = 0;

    for (int z = 12; z <= 14; z++) {
      var topLeft = getTileXY(maxLat, minLng, z);
      var bottomRight = getTileXY(minLat, maxLng, z);

      for (int x = topLeft.x.toInt(); x <= bottomRight.x.toInt(); x++) {
        for (int y = topLeft.y.toInt(); y <= bottomRight.y.toInt(); y++) {
          final folderPath = "$basePath/$z/$x";
          await Directory(folderPath).create(recursive: true);

          final String url = "https://tile.openstreetmap.org/$z/$x/$y.png";
          final String savePath = "$folderPath/$y.png";

          if (!await File(savePath).exists()) {
            try {
              await dio.download(url, savePath);
              totalDownloaded++;

              // 2. The Speed Limit: Pause for 50 milliseconds so we don't get banned
              await Future.delayed(const Duration(milliseconds: 50));

            } catch (e) {
              print("Error downloading tile: $url");
            }
          }
        }
      }
    }
    return "$totalDownloaded tiles saved to $basePath";
  }
}