import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import "package:gpx/gpx.dart";
import "package:gap/gap.dart";
import 'package:malopolskie_dwa_kolka/components/api_connection.dart';
import 'package:malopolskie_dwa_kolka/components/header_text.dart';
import 'package:malopolskie_dwa_kolka/widgets/appbar.dart';
import 'package:malopolskie_dwa_kolka/dataclasses/route_info.dart';

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
  String selectedBikeType = "MTB";

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

  Future<void> getCoordinatesFromName(String name, String type) async{
    if(name.isEmpty){
      return;
    }
    LatLng coordinates =  await ApiConnector.getCoordinatesFromName(name);
    if(type == "start"){
      setState(() {
        startLatLng = coordinates;
      });
    }
    else{
      setState(() {
        endLatLng = coordinates;
      });
    }
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

  void getSuggestions(String input, String type) async{
    if(input.isEmpty){
      return;
    }
    List<String> suggestions = await ApiConnector.getSuggestionsForNames(input);
    if(type == "start"){
      setState(() {
        _routeStartSuggestions = suggestions;
      });
    }
    else{
      setState(() {
        _routeEndSuggestions = suggestions;
      });
    }

  }

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
        floatingActionButton:
            FloatingActionButton.extended(
                backgroundColor: Color.fromARGB(255, 46, 118, 70),
                foregroundColor: Colors.white,
                isExtended: true,
                label: 
                  Row(
                    children: [
                      Icon(Icons.search),
                      Gap(10),
                      Text(
                        "Znajdź trasę",
                        maxLines: 1,
                        
                        ),
                    ],
                  ),
                onPressed: () {
                  if(startLatLng == null || endLatLng == null){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Wybierz punkt startowy i końcowy!')));
                  }
                  else {
                    Navigator.pushNamed(context, '/route', arguments:
                    RouteSelectionInfo(presetName: selectedBikeType,
                        startLocation: startLatLng!,
                        endLocation: endLatLng!));
                }
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              // Starting point selection
              Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  controller: _routeStartController,
                  decoration: InputDecoration(
                    label: Text("Początek trasy"),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.pin_drop),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none
                    ),
                  ),
                  onChanged: (input) {
                    getSuggestions(input, "start");
                  },
                  onSubmitted: (input) {
                    _routeStartSuggestions.clear();
                    getCoordinatesFromName(input, "start");
                  },
                ),
              ),
              if (_routeStartSuggestions.isNotEmpty)
                ListView.builder(
                  padding: EdgeInsets.all(0),
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

              Gap(8),
              
              // Destination point selection
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  controller: _routeEndController,
                  decoration: InputDecoration(
                    label: Text("Koniec trasy"),
                    prefixIcon: Icon(Icons.flag),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide.none
                    ),
                  ),
                  onChanged: (input) {
                    getSuggestions(input, "end");
                  },
                  onSubmitted: (input) {
                    _routeEndSuggestions.clear();
                    getCoordinatesFromName(input, "end");

                  },
                ),
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

              Gap(32),
              
              Text(
                "Rodzaj nawierzchni",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),

              Gap(16),

              Row(
                // TODO: Dodawanie wybranej preferencji do wysyłanego zapytania
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBikeType = "MTB";
                        });
                
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: (selectedBikeType == "MTB" ? Colors.lightGreen:Colors.white),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: 
                          Column(
                            children: [
                              Icon(
                                Icons.terrain,
                                color: (selectedBikeType == "MTB" ? Color.fromARGB(255, 9, 72, 25): Colors.black),
                                ),
                              Text(
                                "MTB",
                                style: TextStyle(
                                  color: (selectedBikeType == "MTB" ? Color.fromARGB(255, 9, 72, 25): Colors.black)
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
                          selectedBikeType = "Szosowy";
                        });
                
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: (selectedBikeType == "Szosowy" ? Colors.lightGreen:Colors.white),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: 
                          Column(
                            children: [
                              Icon(
                                Icons.traffic,
                                color: (selectedBikeType == "Szosowy" ? Color.fromARGB(255, 9, 72, 25): Colors.black),
                                ),
                              Text(
                                "Szosowy",
                                style: TextStyle(
                                  color: (selectedBikeType == "Szosowy" ? Color.fromARGB(255, 9, 72, 25): Colors.black)
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
                          selectedBikeType = "Miejski";
                        });
                
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: (selectedBikeType == "Miejski" ? Colors.lightGreen:Colors.white),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: 
                          Column(
                            children: [
                              Icon(
                                Icons.location_city,
                                color: (selectedBikeType == "Miejski" ? Color.fromARGB(255, 9, 72, 25): Colors.black),
                                ),
                              Text(
                                "Miejski",
                                style: TextStyle(
                                  color: (selectedBikeType == "Miejski" ? Color.fromARGB(255, 9, 72, 25): Colors.black)
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
                          selectedBikeType = "Cross";
                        });
                
                      },
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: (selectedBikeType == "Cross" ? Colors.lightGreen:Colors.white),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: 
                          Column(
                            children: [
                              Icon(
                                Icons.pedal_bike,
                                color: (selectedBikeType == "Cross" ? Color.fromARGB(255, 9, 72, 25): Colors.black),
                                ),
                              Text(
                                "Cross",
                                style: TextStyle(
                                  color: (selectedBikeType == "Cross" ? Color.fromARGB(255, 9, 72, 25): Colors.black)
                                ),
                                )
                              ]
                          ),
                      ),
                    ),
                  ),

                  Gap(16),
                ],
              ),

              Gap(32),

              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 370,
                  height: 370,
                  child:  FlutterMap(
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
              ),
            ],
          ),
          )
        );
  }
}
