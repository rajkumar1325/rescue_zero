import 'package:sqflite/sqflite.dart'; //Database, openDatabase(), getDatabasesPath(), SQL operations (query, insert, delete, execute, etc.)
import 'package:path/path.dart'; // utilities for file path handling. --> join() - builds a valid cross-platform file path.



class DatabaseHelper {
  static Future<Database> initDb() async { //no instance neeeded, so make methods static

    // await getDatabasesPath() --> Returns OS-specific directory, then name the file inside it
    String path = join(await getDatabasesPath(), 'emergency_zones.db');
    print("Database path: $path"); // tells you WHERE the saved file is located

    return await openDatabase( //Opens existing DB or creates new.
      path,
      version: 3, // Database schema version. -- Used for migrations.
      onCreate: (Database db, int version) async { //onCreate runs only when, The database file does NOT exist yet

        //SQL Table Creation (TableName - safe_zones)
        await db.execute(''' 
          CREATE TABLE safe_zones(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            lat REAL,
            lng REAL,
            type TEXT,
            phone TEXT,
            hours TEXT,
            details TEXT
          )
        ''');
        // starts completely empty database
      },
    );
  }

  /// Returns all rows
  static Future<List<Map<String, dynamic>>> getSafeZones() async { //returns list of rows --> under each row = column → key+value
    final db = await initDb(); //Opens DB connection.
    return db.query('safe_zones'); // (SELECT * FROM safe_zones) --> Returns all rows.
  }

  /// Deletes everything in the table (useful if the user travels to a new city)
  static Future<void> clearAllSafeZones() async {
    final db = await initDb();
    await db.delete('safe_zones'); // (DELETE FROM safe_zones; --> table remains, data deleted)
  }

  // Saves a single location grabbed from the internet
  static Future<void> insertSafeZone(Map<String, dynamic> zone) async {
    final db = await initDb(); // (INSERT INTO safe_zones (...) VALUES (...); )
    await db.insert('safe_zones', zone);
  }
}
