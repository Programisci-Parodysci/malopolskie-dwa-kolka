import 'package:flutter/material.dart';
import 'package:malopolskie_dwa_kolka/components/appbar.dart';
import 'package:malopolskie_dwa_kolka/dataclasses/route_info.dart';

class RouteWidget extends StatelessWidget {
  const RouteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context)!.settings.arguments as Email;

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
}