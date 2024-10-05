import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_hifz_tracker/models/homework/homework_data.dart';
import 'package:markaz_umaza_hifz_tracker/models/parent.dart';
import 'package:markaz_umaza_hifz_tracker/models/user_data.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/home_app_bar.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/logout_dialog.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/speed_dial_menu.dart';
import 'package:markaz_umaza_hifz_tracker/models/student/student_tile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/student/student.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  // late Future<PostgrestList> data;
  final parentNameController = TextEditingController();
  final idController = TextEditingController();
  final fullNameController = TextEditingController();
  final ageController = TextEditingController();
  final originController = TextEditingController();
  final hafizController = TextEditingController();
  late UserData user;
  late HomeworkData homework;
  late final userId = user.userId;
  late final data = user.getData();

  @override
  void dispose() {
    parentNameController.dispose();
    idController.dispose();
    fullNameController.dispose();
    ageController.dispose();
    originController.dispose();
    hafizController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user = ref.watch(userData);
    homework = ref.watch(homeworkData);

    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
      appBar: HomeAppBar(
        title: 'Students',
      ),
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
                return Text('Oops, something went wrong, please try again.');
              } else if (snapshot.hasData) {
                Parent parentData = Parent.fromJson(snapshot.data![0]);

                if (user.students.isEmpty) {
                  user.students = parentData.students;
                }

                SchedulerBinding.instance.addPostFrameCallback((_) {
                  if (parentData.fullName == null) {
                    dialogueBuilderTwo(context, parentNameController, userId);
                  }
                });

                return ListView.builder(
                  itemCount: user.students.length,
                  itemBuilder: (context, index) {
                    Student studentData = user.students[index];

                    return index < user.students.length - 1
                        ? StudentTile(
                            student: studentData,
                            bottomPadding: 0,
                            onTap: () {
                              homework.setStudentId(studentData.id);
                              Navigator.pushNamed(context, '/homework');
                            },
                          )
                        : StudentTile(
                            student: studentData,
                            bottomPadding: 94,
                            onTap: () {
                              homework.setStudentId(studentData.id);
                              Navigator.pushNamed(context, '/homework');
                            },
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

          user.addStudent(id, fullName, age, origin);

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
