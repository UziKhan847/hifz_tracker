import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_hifz_tracker/models/parent.dart';
import 'package:markaz_umaza_hifz_tracker/models/user_data.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/home_app_bar.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/logout_dialog.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/speed_dial_menu.dart';
import 'package:markaz_umaza_hifz_tracker/main.dart';
import 'package:markaz_umaza_hifz_tracker/models/student_tile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/student.dart';

class Homepage extends ConsumerWidget {
  Homepage({super.key});

  // late Future<PostgrestList> data;

  // final userId = supabase.auth.currentUser!.id;

  final parentNameController = TextEditingController();
  final idController = TextEditingController();
  final fullNameController = TextEditingController();
  final ageController = TextEditingController();
  final originController = TextEditingController();
  final hafizController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userData).userId;
    final data = ref.watch(userData).getData();

    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
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
                    dialogueBuilderTwo(context, parentNameController, userId);
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
                child: CircularProgressIndicator(),
              );
            }),
      ),
      floatingActionButton: SpeedDialMenu(
        idController: idController,
        fullNameController: fullNameController,
        ageController: ageController,
        originController: originController,
        hafizController: hafizController,
        onPressed: () async {
          final id = int.parse(idController.text);
          final fullName = fullNameController.text;
          final age = int.parse(ageController.text);
          final origin = originController.text;
          //final hafiz = hafizController.text;

          ref.read(userData).addStudent(id, fullName, age, origin);

          if (context.mounted) {
            Navigator.pop(context, 'Add');
          }

          idController.clear();
          fullNameController.clear();
          ageController.clear();
          originController.clear();
        },
      ),
    );
  }
}
