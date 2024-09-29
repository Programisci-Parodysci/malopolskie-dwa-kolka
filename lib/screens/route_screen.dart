import 'package:flutter/material.dart';
import 'package:malopolskie_dwa_kolka/widgets/appbar.dart';
import 'package:malopolskie_dwa_kolka/dataclasses/route_info.dart';
import 'package:malopolskie_dwa_kolka/components/header_text.dart';
import 'package:malopolskie_dwa_kolka/widgets/route_widget.dart';
import 'package:gap/gap.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key, required this.routeInfo});
  final RouteInfo routeInfo;

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  List<String> routeChoice = ["safest","quickest"];
  String selectedRoute = "safest";

  

  Widget build(BuildContext content){
    return Scaffold(
      appBar: const CustomAppBar(title: "Wybierz trasę"),
      body: 
        Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRoute = "safest";
                        });
                
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: (selectedRoute == "safest" ? Colors.lightGreen:Colors.white),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: 
                          Column(
                            children: [
                              Icon(
                                Icons.health_and_safety,
                                color: (selectedRoute == "safest" ? Color.fromARGB(255, 9, 72, 25): Colors.black),
                                size: 32,
                                ),
                              Text(
                                "safest",
                                style: TextStyle(
                                  color: (selectedRoute == "safest" ? Color.fromARGB(255, 9, 72, 25): Colors.black)
                                ),
                                )
                              ]
                          ),
                      ),
                    ),
                  ),

                  Gap(16),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRoute = "fastest";
                        });
                
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: (selectedRoute == "fastest" ? Colors.lightGreen:Colors.white),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: 
                          Column(
                            children: [
                              Icon(
                                  Icons.fast_forward,
                                  color: (selectedRoute == "fastest" ? Color.fromARGB(255, 9, 72, 25): Colors.black),
                                  size: 32
                                ),
                              Text(
                                "fastest",
                                style: TextStyle(
                                  color: (selectedRoute == "fastest" ? Color.fromARGB(255, 9, 72, 25): Colors.black)
                                ),
                                )
                              ]
                          ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              RouteWidget(widget.routeInfo),
              ],
              
          ),
        )
    );
  }
}




    // appBar: CustomAppBar(title: "Trasa"),
    // body: Column(
    //   children: [
    //     HeaderText(text: "Mapa trasy"),
    //               // TODO: Widget z mapą
    //               Gap(4),
    //               // Placeholder
    //               AspectRatio(
    //                 aspectRatio: 1.4,
    //                 child: Material(
    //                   color: Colors.white,
    //                   elevation: 5.0,
    //                   borderRadius: BorderRadius.all(Radius.circular(10)),
    //                   child: Text("tutaj idzie mapa"),
    //                 ),
    //               ),

    //  ],
    // ),