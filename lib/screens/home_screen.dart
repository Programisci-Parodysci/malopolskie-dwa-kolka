import 'package:flutter/material.dart';
import "package:gap/gap.dart";
import 'package:malopolskie_dwa_kolka/dataclasses/route_info.dart';
import 'package:malopolskie_dwa_kolka/widgets/appbar.dart';
import 'package:malopolskie_dwa_kolka/components/header_text.dart';
import 'package:malopolskie_dwa_kolka/widgets/small_route_preview.dart';

class HomeScreen extends StatelessWidget{

  const HomeScreen({super.key});

  //final List<RouteInfo> usersRoutes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Małopolskie2Kółka"),
      // bottomNavigationBar: NavigationBar(destinations: const[]),
      body:
          Container(
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
            ),
            child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderText(text: "Twoja lokalizacja"),
                  // TODO: Widget z mapą
                  Gap(8),
                  // Placeholder
                  const AspectRatio(
                    aspectRatio: 1.4,
                    child: Material(
                      color: Colors.white,
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Text("tutaj idzie mapa"),
                    ),
                  ),
                  
                  Gap(24),

                 
                        HeaderText(text: "Twoje trasy"), 
                  
                  // TODO: Sciągnieta lista tras uzytkownika
                  Container(
                    height: 220,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 0,//usersRoutes.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Gap(2),
                            //SmallRoutePreview(routeInfo: usersRoutes[index]),
                            Gap(16)
                          ],
                        );
                      }
                      ),
                  ),

                  Gap(42),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 46, 118, 70)
                          ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/route_selection');
                        },
                        child: 
                        const Column(
                          children: [
                            Gap(4),
                            Icon(
                              Icons.add_road_rounded,
                              size: 42,
                              ),
                            Text("Znajdź trasę"),
                            Gap(4),
                            ])
                        )),
                      const Gap(16),
                      Expanded(child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 130, 43, 41)
                          ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/user_report');
                        },
                        child: 
                        const Column(
                          children: [
                            Gap(4),
                            Icon(
                              Icons.warning_rounded,
                              size: 42,
                              ),
                            Text("Dodaj zagrożenie"),
                            Gap(4),
                            ])
                        )),                    ],
                  ),

                ],
              ),
          ),
    );
  }

}