import 'package:latlong2/latlong.dart';

class RouteInfo {
  late String startLocation;
  late String endLocation;
  late double routeLength;
  List<LatLng> gpx;
  late double safetyRating;
  late double userRating;

  RouteInfo({startLocation, destinationLocation, routeLength,
      required this.gpx, safetyRating, userRating});
}

class RouteSelectionInfo {
  LatLng startLocation;
  LatLng endLocation;
  String presetName;

  RouteSelectionInfo({required this.startLocation, required this.endLocation, required this.presetName});
}