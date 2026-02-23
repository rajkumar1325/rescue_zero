# 🚨 Rescue Zero

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)
![Open Source](https://img.shields.io/badge/Open_Source-10000_Free-green?style=for-the-badge)

> **A production-ready, fully offline-first mobile application designed to save lives when cell towers go down.** Rescue Zero provides real-time, completely offline GPS tracking, emergency routing to the nearest safe zones (hospitals and police stations), and a zero-latency survival guide. It utilizes an event-driven architecture to silently cache a massive 50km radius of emergency data to local device storage, ensuring users have a bulletproof safety net even during complete internet blackouts.

---

## ✨ Core Architecture & Features

* **🌍 True Offline-First Architecture:** Downloads and serves raw OpenStreetMap `.png` tiles and emergency locations directly from the device's local file system. Works completely independent of cellular networks.
* **📡 Event-Driven Background Sync:** Listens for network state changes. When the device reconnects to the internet, it silently pings the Overpass API to update local SQLite records without blocking the main UI thread.
* **📍 Dynamic Radar UI:** Features a highly reactive mapping interface. As the user drags the search radius slider, the app instantly performs continuous local geospatial math to filter and render map pins in real-time—requiring zero API calls.
* **🔋 "True Black" Battery Saver:** A custom algorithmic toggle that uses a `ColorFilter.matrix` to mathematically invert bright map tiles and switch the UI to pure black. This turns off AMOLED pixels to severely reduce battery drain during prolonged emergencies.
* **⚕️ Zero-Latency Survival Guide:** An integrated, offline first-aid database utilizing an `IndexedStack` to maintain the map's memory state while reading. Includes a seamless English-to-Hinglish localization toggle for rapid comprehension.
* **🔗 One-Tap SOS Location Share:** Grabs high-accuracy GPS coordinates and generates a formatted Google Maps deep link injected directly into the native sharing menu.

---

## 🛠️ Tech Stack & Packages Used

Building a reliable offline map requires carefully selecting packages that do not rely on constant cloud API pings. Here is the engineering breakdown of the tools used and why they were chosen:

| Package | Purpose | SDE Justification (Why it was used) |
| :--- | :--- | :--- |
| **`flutter_map`** | Mapping Engine | Chosen over Google Maps API because it natively supports rendering raw, local `.png` map tiles from the device's file system for 100% offline capability. |
| **`sqflite`** | Local Database | Used to create a relational SQL database directly on the device, caching the 50km radius of emergency contacts for zero-latency offline querying. |
| **`dio`** | Network / HTTP Client | Handles complex HTTP requests to the Overpass API. Crucial for injecting custom `User-Agent` headers and throttling tile downloads to prevent 403 server blocks. |
| **`geolocator`** | GPS & Hardware | Directly accesses the device's GPS chip to pull high-accuracy latitude/longitude coordinates without relying on Wi-Fi or cellular triangulation. |
| **`connectivity_plus`** | Network Listener | Enables event-driven architecture by listening for Wi-Fi/Cellular state changes to trigger silent, background database synchronization when internet is restored. |
| **`path_provider`** | File System Access | Grants precise read/write access to the Android/iOS internal file system to securely store and retrieve thousands of downloaded map tiles. |
| **`latlong2`** | Spatial Mathematics | Performs complex geospatial calculations (Haversine formula) locally on the CPU to determine the exact distance between the user and safe zones dynamically. |
| **`share_plus`** | Native Intents | Hooks into the OS's native sharing capabilities to broadcast SOS messages via WhatsApp, SMS, or email instantly. |

---

## 📂 Folder Structure

```text
lib/
│
├── main.dart               # Entry point, UI routing, State Management & Listeners
├── database_helper.dart    # SQLite CRUD operations & Schema definition
├── api_sync.dart           # Dio REST client, Overpass QL queries, and JSON parsing
├── offline_util.dart       # Asynchronous tile downloading and file system management
└── first_aid_data.dart     # Static JSON-style data model for the Survival Guide
```

---

## 🚀 How to Run Locally
- Follow these precise steps to run the application on your local machine.

1. Clone the repo:  
   ```https://github.com/rajkumar1325/rescue_zero.git```

   
2. Navigate to the project directory:  ```cd rescue_zero```


3. Fetch the dependencies:  
```flutter pub get```

4. Run the app on a physical device: (Note: A physical device is highly recommended over an emulator for accurate GPS and file-system testing): 
```flutter run```


## 🔮 Future Scope
- - Implement OSRM (Open Source Routing Machine) to snap the emergency polyline perfectly to street networks instead of point-to-point drawing.
- - Add native background SMS capability to fire automated SOS messages to predefined emergency contacts via Android intents.


--- 
## 🤝 Let's Connect
I am actively looking for Software Development Engineer (SDE) roles. If you found this architecture interesting or helpful, feel free to drop a ⭐ on the repository!

LinkedIn: https://www.linkedin.com/in/rajkumar0104/

GitHub: https://github.com/rajkumar1325

Email: Rajkumar.rk0104@gmail.com