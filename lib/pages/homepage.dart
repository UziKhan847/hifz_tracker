import 'package:flutter/material.dart';
import 'package:markaz_umaza_hifz_tracker/components/home_app_bar.dart';
import 'package:markaz_umaza_hifz_tracker/components/speed_dial_menu.dart';
import 'package:markaz_umaza_hifz_tracker/models/student_tile.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(253, 253, 253, 1),
      appBar: HomeAppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/school_supplies_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return StudentTile();
          },
        ),
      ),
      floatingActionButton: SpeedDialMenu(onPressed: () {}),
    );
  }
}
