import 'package:flutter/material.dart';
import 'package:malopolskie_dwa_kolka/components/appbar.dart';
import 'package:malopolskie_dwa_kolka/dataclasses/route_info.dart';

class RouteWidget extends StatelessWidget {
  

  // Passing displayed route
  const RouteWidget({super.key, required this.routeInfo});
  final RouteInfo routeInfo;

  @override
  Widget build(BuildContext context) {
   return const Scaffold(
    appBar: CustomAppBar(title: "Propozycje"),
    body: Column(
      children: [
        
     ],
    ),
   );
  }
}