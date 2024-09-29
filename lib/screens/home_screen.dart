import 'package:flutter/material.dart';
import 'package:malopolskie_dwa_kolka/components/appbar.dart';
import 'package:malopolskie_dwa_kolka/components/header_text.dart';

class HomeScreen extends StatelessWidget{

  const HomeScreen({super.key});

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

                  // Placeholder
                  AspectRatio(
                    aspectRatio: 1.4,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  


                  Row(
                    children: [
                      ElevatedButton(onPressed: () {}, child: const Text("Znajdź trasę")),
                      ElevatedButton(onPressed: () {}, child: const Text("Dodaj zagrożenie"))
                    ],
                  ),

                  const HeaderText(text: "Twoje trasy"),
                  // TODO: Sciągnieta lista tras uzytkownika
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const ScrollPhysics(),
                      children: [
                        Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        
                        Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: const BoxDecoration(
                            
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        
                        
                      ],
                    ),
                  ),

                ],
              ),
          ),
    );
  }

}