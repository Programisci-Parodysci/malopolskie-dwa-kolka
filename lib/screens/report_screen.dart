import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:malopolskie_dwa_kolka/components/header_text.dart';
import 'package:malopolskie_dwa_kolka/widgets/appbar.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Zgłoś zagrożenie"),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Color.fromARGB(255, 46, 118, 70),
            foregroundColor: Colors.white,
            isExtended: true,
            label: const Row(
              children: [
                Icon(Icons.add_rounded),
                Gap(10),
                Text(
                  "Dodaj zgłoszenie",
                  maxLines: 1,
                ),
              ],
            ),
            onPressed: () {}),
        body: Container(
          margin: EdgeInsets.all(32),
          child: Column(
            children: [
              const HeaderText(text: "Dodaj lokalizację"),
              Container(
                  width: 350,
                  height: 150,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.all(16),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                  )),
              Gap(16),
              HeaderText(text: "Dodaj zdjęcie"),
              Container(
                  width: 350,
                  height: 150,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  margin: EdgeInsets.all(16),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                  )),
              Gap(32),
              Material(
                elevation: 5.0,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  maxLines: 6,
                  decoration: InputDecoration(
                    labelText: 'Opis',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(Icons.edit),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
