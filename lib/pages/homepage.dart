import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:markaz_umaza_hifz_tracker/extensions/context_extensions.dart';
import 'package:markaz_umaza_hifz_tracker/main.dart';
import 'package:markaz_umaza_hifz_tracker/models/homework/homework_data.dart';
import 'package:markaz_umaza_hifz_tracker/models/parent.dart';
import 'package:markaz_umaza_hifz_tracker/models/user_data.dart';
import 'package:markaz_umaza_hifz_tracker/utils/margins.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/dialog/dialog.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/home_app_bar.dart';
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
  final phoneNumberController = TextEditingController();
  late UserData user;
  late HomeworkData homework;
  late final userId = user.userId;
  late final data = user.getData();
  bool _isLoading = false;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    parentNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  void loadCircle() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  String? get errorText {
    final text = parentNameController.value.text;
    if (text.isEmpty) {
      return "Can't be empty";
    }
    return null;
  }

  Future<void> updateDetails() async {
    try {
      await supabase.from('profiles').update({
        'full_name': parentNameController.text,
        'phone_number': phoneNumberController.text
      }).eq(
        'id',
        userId,
      );

      if (mounted) {
        context.showSnackBar("Details Updated!");
      }

      if (mounted) {
        Navigator.pop(context, 'Cancel');
      }
    } catch (error) {
      if (mounted) {
        context.showSnackBar(
          'Unexpected error occurred',
          isError: true,
        );
      }
    }
  }

  SizedBox updateDialogContent() {
    return SizedBox(
      height: 170,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: parentNameController,
              decoration: InputDecoration(
                labelText: "Full Name",
              ),
              validator: (name) => name!.isEmpty ? "Name can't be empty" : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Margins.vertical10,
            IntlPhoneField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText:
                    'Phone Number', // https://pub.dev/packages/country_code_picker
              ),
              initialCountryCode: 'CA',
              onChanged: (phone) {},
              validator: (phone) => phone?.number.isEmpty == true
                  ? "Phone Number can't be empty"
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    user = ref.watch(userData);
    homework = ref.watch(homeworkData);

    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
      appBar: HomeAppBar(
        automaticallyImplyLeading: false,
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
                  if (parentData.fullName == null ||
                      parentData.phoneNumber == null) {
                    DialogMenu(
                      barrierDismissible: false,
                      title: 'Please Enter Your Details',
                      content: updateDialogContent(),
                      actions: <Widget>[
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                updateDetails();
                              }
                            },
                            child: const Text('Update'),
                          ),
                        ),
                      ],
                    ).dialogueBuilder(context);
                  }
                });

                return ListView.builder(
                  itemCount: user.students.length,
                  itemBuilder: (context, index) {
                    Student studentData = user.students[index];

                    return StudentTile(
                      student: studentData,
                      bottomPadding: index < user.students.length - 1 ? 0 : 94,
                      onTap: () {
                        homework.studentId = studentData.id;
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
        onPressed: () async {
          DialogMenu(
            barrierDismissible: true,
            title: 'Please Enter Your Details',
            content: updateDialogContent(),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        updateDetails();
                      }
                    },
                    child: const Text('Update'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (context.mounted) {
                        Navigator.pop(context, 'Cancel');
                      }
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ).dialogueBuilder(context);
        },
      ),
    );
  }
}
