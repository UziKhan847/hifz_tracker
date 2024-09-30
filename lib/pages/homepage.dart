import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:markaz_umaza_hifz_tracker/models/parent.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/home_app_bar.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/logout_dialog.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/speed_dial_menu.dart';
import 'package:markaz_umaza_hifz_tracker/main.dart';
import 'package:markaz_umaza_hifz_tracker/models/student_tile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/student.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<PostgrestList> data;
  final userId = supabase.auth.currentUser!.id;
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    data = getData();
    print("This is the data retrieved: $data");
  }

  Future<PostgrestList> getData() async =>
      supabase.from('profiles').select('*, students(*)').eq('id', userId);

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
            image: AssetImage("images/school_supplies_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<PostgrestList>(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong, please try again.');
              } else if (snapshot.hasData) {
                Parent parentData = Parent.fromJson(snapshot.data![0]);

                List<Student> studentList = parentData.students;

                SchedulerBinding.instance.addPostFrameCallback((_) {
                  if (parentData.fullName == null) {
                    dialogueBuilderTwo(context, nameController, userId);
                  }
                });

                return ListView.builder(
                  itemCount: studentList.length,
                  itemBuilder: (context, index) {
                    Student studentData = studentList[index];

                    return StudentTile(
                      name: studentData.fullName,
                      id: studentData.id,
                      age: studentData.age,
                      origin: studentData.origin,
                      hafiz: studentData.hafiz,
                    );
                  },
                );
              }

              return Center(
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(),
                ),
              );
            }),
      ),
      floatingActionButton: SpeedDialMenu(onPressed: () {}),
    );
  }
}
