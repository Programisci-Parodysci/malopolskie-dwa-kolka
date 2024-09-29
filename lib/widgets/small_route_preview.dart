import 'package:flutter/material.dart';
import 'package:malopolskie_dwa_kolka/dataclasses/route_info.dart';


class SmallRoutePreview extends StatelessWidget{

  const SmallRoutePreview({super.key, required this.routeInfo});

  final RouteInfo routeInfo;


  @override
  Widget build(BuildContext context) {
    return Container(
          width: 200,
          height: 200,
          child:Material(
      elevation: 5.0,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.white,
      child:
         Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Text(routeInfo.startLocation),
            // Text(routeInfo.endLocation),
            // Text(routeInfo.routeLength.toString())
          ],
          ),
        ),
    );
  }
}