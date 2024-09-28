import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:convert';

import 'package:malopolskie_dwa_kolka/dataclasses/route_info.dart';

class ApiConnector {
  static const host = "http://srv27.mikr.us:40088/";

  static Future<RouteInfo> getRoute(
      String presetName, LatLng startLocation, LatLng endLocation) async {
    final url = Uri.http(host, "find_route", {
      'preset_name': presetName,
      'start_latitude': startLocation.latitude,
      'query2': startLocation.longitude,
      'query3': endLocation.latitude,
      'end_longitude': endLocation.longitude
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<LatLng> gpxList = data
          .map((point) => LatLng(point["latitude"], point["longitude"]))
          .toList();

      return RouteInfo(gpx: gpxList);
    } else {
      throw Exception(
          'failed to fetch data: HTTP status ${response.statusCode}');
    }
  }
}
