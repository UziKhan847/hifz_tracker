import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:markaz_umaza_hifz_tracker/extensions/context_extensions.dart';
import 'package:markaz_umaza_hifz_tracker/main.dart';
import 'package:markaz_umaza_hifz_tracker/providers/homework_data.dart';
import 'package:markaz_umaza_hifz_tracker/models/parent.dart';
import 'package:markaz_umaza_hifz_tracker/providers/user_data.dart';
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
  String? isoCode;
  String? dialCode;
  String? phoneNumber;
  Parent parentData = Parent(
      students: [],
      id: '',
      fullName: null,
      phoneNumber: null,
      isoCode: null,
      dialCode: null);

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

  InputDecoration setInputDecoration(String labelText) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFA36F1A)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF17588b)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      labelText: labelText,
    );
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
        'iso_code': isoCode,
        'dial_code': dialCode,
        'phone_number': phoneNumber,
      }).eq(
        'id',
        userId,
      );

      setState(() {
        parentData.fullName = parentNameController.text;
        parentData.isoCode = isoCode;
        parentData.phoneNumber = phoneNumber;
      });

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

  Future<void> logOut() async {
    try {
      Navigator.popUntil(context, (route) => route.isFirst);
      supabase.auth.signOut();
      user.students.clear();
      if (mounted) {
        context.showSnackBar('Logout succesful!');
      }
    } catch (e) {
      if (mounted) {
        context.showSnackBar('Logout unsuccesful!', isError: true);
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
              decoration: setInputDecoration('Full Name'),
              validator: (name) => name!.isEmpty ? "Name can't be empty" : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Margins.vertical10,
            IntlPhoneField(
              controller: phoneNumberController,
              decoration: setInputDecoration('Phone Number'),
              initialCountryCode: parentData.isoCode ?? 'CA',
              onChanged: (phone) {
                if (phone.isValidNumber()) {
                  isoCode = phone.countryISOCode;
                  dialCode = phone.countryCode;
                  phoneNumber = phone.number;
                }
              },
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
                if (parentData.id.isEmpty) {
                  parentData = Parent.fromJson(snapshot.data![0]);
                }

                if (user.students.isEmpty) {
                  user.students = parentData.students;
                }

                phoneNumber ??= parentData.phoneNumber;
                isoCode ??= parentData.isoCode;
                dialCode ??= parentData.dialCode;

                if (parentNameController.text == '') {
                  parentNameController.text = parentData.fullName ?? '';
                }
                if (phoneNumberController.text == '') {
                  phoneNumberController.text = parentData.phoneNumber ?? '';
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
        onTap: () async {
          DialogMenu(
            barrierDismissible: false,
            title: 'Please Enter Your Details',
            content: updateDialogContent(),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  if (context.mounted) {
                    Navigator.pop(context, 'Cancel');
                  }

                  parentData.fullName != null
                      ? parentNameController.text = "${parentData.fullName}"
                      : parentNameController.clear();
                  parentData.phoneNumber != null
                      ? phoneNumberController.text = "${parentData.phoneNumber}"
                      : phoneNumberController.clear();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    updateDetails();
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ).dialogueBuilder(context);
        },
        onPressedLogout: () async {
          await logOut();
        },
      ),
    );
  }
}
