import 'package:flutter/material.dart';
import 'package:malopolskie_dwa_kolka/components/appbar.dart';
import 'package:malopolskie_dwa_kolka/dataclasses/route_info.dart';

class RouteWidget extends StatefulWidget{
  const RouteWidget({super.key});
  @override
  State<StatefulWidget> createState() => _RouteWidgetState();
}

class _RouteWidgetState extends State<RouteWidget> {
  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: const CustomAppBar(title: "Propozycje"),
    body: Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),

        ),
      ],
    ),
   );
  }
}