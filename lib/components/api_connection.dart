import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:convert';

import 'package:malopolskie_dwa_kolka/dataclasses/route_info.dart';

class ApiConnector {
  static const host = "srv27.mikr.us:40088";

  static Future<RouteInfo> getRoute(
      String presetName, LatLng startLocation, LatLng endLocation) async {
    final url = Uri.http(host, "/find_route", {
      'preset_name': presetName,
      'start_latitude': startLocation.latitude,
      'start_longitude': startLocation.longitude,
      'end_latitude': endLocation.latitude,
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

  static Future<List<String>> getSuggestionsForNames(String addressStart) async{
    final url = Uri.http(host, "/get_sugg", {
      'letters': addressStart,
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<String> suggestions = data.cast<String>();
      return suggestions;
    } else {
      throw Exception(
          'failed to fetch data: HTTP status ${response.statusCode}');
    }
  }
}
