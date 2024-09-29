import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:malopolskie_dwa_kolka/components/api_connection.dart';
import 'package:malopolskie_dwa_kolka/dataclasses/route_info.dart';

class RouteWidget extends StatefulWidget {
  const RouteWidget({super.key, required RouteSelectionInfo routeSelectionInfo});

  get routeSelectionInfo => null;

  @override
  State<RouteWidget> createState() => _RouteWidgetState();
}

class _RouteWidgetState extends State<RouteWidget> {
  late RouteInfo routeInfo;

  @override
  Widget build(BuildContext context) {
    final routeSelectionInfo =  widget.routeSelectionInfo;

    return FutureBuilder<RouteInfo>(
        future: ApiConnector.getRoute(
            routeSelectionInfo.presetName, routeSelectionInfo.startLocation, routeSelectionInfo.endLocation),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            routeInfo = snapshot.data!;
            return FlutterMap(
              options:
                  const MapOptions(initialCenter: LatLng(50.067720, 19.991566)),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.malopolskie-dwa-kolka.app',
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routeInfo.gpx,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Text('No route available');
          }
        });
  }
}
