import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import "package:gpx/gpx.dart";
import 'dart:io';

import 'package:malopolskie_dwa_kolka/components/appbar.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Map<String, List<LatLng>> proposedRoutes = {};

  @override
  void initState() {
   // proposedRoutes["test"] = loadGpx();
    super.initState();
  }

  Future<String> readFile(String filePath) async {
    try {
      final file = File(filePath);
      // Check if file exists
      if (await file.exists()) {
        dynamic data = await file.readAsString();
        return data;
      } else {
        return "";
        debugPrint("File does not exist");
      }
    } catch (e) {
      return "";
      debugPrint("Error reading file: $e");
    }
  }

  dynamic loadGpx() {
    String? data = "DSDADSADAASDSA";
    readFile("../data/export.gpx").then((value) {
      data = value;
      debugPrint(data);
    });
    debugPrint(data);
    assert(data != null);
    return GpxReader().fromString(data!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Trasy"),
      body: FutureBuilder<String>(
          future: readFile(
              "../data/export.gpx"), // The async function to fetch data
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading spinner while waiting for the data
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // Handle any errors that occur during the fetch
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // Display the data once it's loaded
              return FlutterMap(
                options: const MapOptions(initialCenter: LatLng(50.067720, 19.991566)),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.malopolskie-dwa-kolka.app',
                  ),
                  /*PolylineLayer(
                    polylines: [
                      Polyline(
                        points: proposedRoutes["test"]!,
                        strokeWidth: 4.0,
                        color: Colors.blue,
                      ),
                    ],
                  ),*/
                ],
              );
            } else {
              // Handle the case when there's no data, though it shouldn't happen here
              return Text('No data available');
            }
          }),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
