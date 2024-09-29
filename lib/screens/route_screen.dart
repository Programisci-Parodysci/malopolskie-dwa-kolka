import 'package:flutter/material.dart';
import 'package:malopolskie_dwa_kolka/components/appbar.dart';
import 'package:malopolskie_dwa_kolka/dataclasses/route_info.dart';

class RouteScreen extends StatelessWidget {
  

  // Passing displayed route
  const RouteScreen({super.key, required this.routeSuggestions});
  final Map<String,RouteInfo> routeSuggestions;

  @override
  Widget build(BuildContext context) {
   return const Scaffold(
    appBar: CustomAppBar(title: "Propozycje"),
    body: Column(
      children: [
        Row(
          children: [
            ElevatedButton(onPressed: null, child: Text("")),
            ElevatedButton(onPressed: null, child: Text("")),
            ElevatedButton(onPressed: null, child: Text("")),
            ElevatedButton(onPressed: null, child: Text("")),
          ],

        ),

     ],
    ),
   );
  }
}