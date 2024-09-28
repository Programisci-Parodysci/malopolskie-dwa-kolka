import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiConnector {
  final host = "http://srv27.mikr.us:40088/";

  Future<RouteInfo> getRoute(String presetName, double startLatitude,
      double startLongitude, double endLatitude, double endLongitude) async{
    final url = Uri.http(host, "find_route", {
      'preset_name': presetName,
      'start_latitude': startLatitude,
      'query2': startLongitude,
      'query3': endLatitude,
      'end_longitude': endLongitude
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      routeInfo = RouteInfo(data);

      return RouteInfo;
    } else {
      throw Exception(
          'failed to fetch data: HTTP status ${response.statusCode}');
    }
    }
  }
}
