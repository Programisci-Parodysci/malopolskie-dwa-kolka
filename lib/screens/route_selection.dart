import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import "package:gpx/gpx.dart";
import 'dart:io';

import 'package:malopolskie_dwa_kolka/widgets/appbar.dart';

class RouteSelection extends StatefulWidget {
  const RouteSelection({super.key});

  @override
  State<RouteSelection> createState() => _RouteSelectionState();
}

class _RouteSelectionState extends State<RouteSelection> {
  String? routeStartName;
  String? routeEndName;
  LatLng? startLatLng;
  LatLng? endLatLng;
  final TextEditingController _routeStartController = TextEditingController();
  final TextEditingController _routeEndController = TextEditingController();
  List<String> _routeStartSuggestions = [];
  List<String> _routeEndSuggestions = [];
  Marker? startPointMarker;
  Marker? endPointMarker;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _routeStartController.dispose();
    _routeEndController.dispose();
    super.dispose();
  }

  LatLng getCoordinatesFromName(String name) {
    return LatLng(50.067720, 19.991566);
  }

  void setStartPointOnMap(LatLng coordinates) {
    startPointMarker = Marker(
        point: coordinates,
        child: Icon(
          Icons.pedal_bike_rounded,
          color: Colors.green.shade500,
        ));
  }

  void setEndPointOnMap(LatLng coordinates) {
    endPointMarker = Marker(
        point: coordinates,
        child: Icon(
          Icons.sports_score_rounded,
          color: Colors.green.shade500,
        ));
  }

  void getSuggestions(String input) {}

  LatLng getMapCenter() {
    if (startPointMarker == null) {
      if (endPointMarker == null) {
        return LatLng(50.067720, 19.991566);
      } else {
        return endPointMarker!.point;
      }
    } else {
      if (endPointMarker == null) {
        return startPointMarker!.point;
      } else {
        return LatLng(
            (startPointMarker!.point.latitude +
                    endPointMarker!.point.latitude) /
                2,
            (startPointMarker!.point.longitude +
                    endPointMarker!.point.longitude) /
                2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Wybierz trasę"),
        body: Column(
          children: [
            TextField(
              controller: _routeStartController,
              decoration: InputDecoration(
                hintText: "Początek trasy",
                border: OutlineInputBorder(),
              ),
              onChanged: (input) {
                getSuggestions(input);
              },
              onSubmitted: (input) {
                LatLng coordinates = getCoordinatesFromName(input);
              },
            ),
            if (_routeStartSuggestions.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _routeStartSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_routeStartSuggestions[index]),
                    onTap: () {
                      _routeStartController.text =
                          _routeStartSuggestions[index];
                      setState(() {
                        _routeStartSuggestions.clear();
                      });
                    },
                  );
                },
              ),
            TextField(
              controller: _routeEndController,
              decoration: InputDecoration(
                hintText: "Koniec trasy",
                border: OutlineInputBorder(),
              ),
              onChanged: (input) {
                getSuggestions(input);
              },
            ),
            if (_routeEndSuggestions.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _routeEndSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_routeEndSuggestions[index]),
                    onTap: () {
                      _routeEndController.text = _routeEndSuggestions[index];
                      setState(() {
                        _routeEndController.clear();
                      });
                    },
                  );
                },
              ),
            Row(),
            Expanded(
              child: FlutterMap(
                options: const MapOptions(
                    initialCenter: LatLng(50.067720, 19.991566)),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.malopolskie-dwa-kolka.app',
                  ),
                  MarkerLayer(
                      markers: [startPointMarker, endPointMarker]
                          .where((item) => item != null)
                          .toList()
                          .cast<Marker>())
                ],
              ),
            ),
          ],
        ));
  }
}
