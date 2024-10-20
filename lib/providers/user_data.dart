import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_hifz_tracker/main.dart';
import 'package:markaz_umaza_hifz_tracker/models/parent.dart';
import 'package:markaz_umaza_hifz_tracker/models/student/student.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userData = ChangeNotifierProvider<UserData>((ref) {
  return UserData();
});

class UserData extends ChangeNotifier {
  String get userId => supabase.auth.currentUser!.id;

  List<Student> students = [];

  late Parent parent;

  Future<PostgrestList> getData() async => supabase
      .from('profiles')
      .select('*, students(*)')
      .eq('id', userId)
      .order('id', referencedTable: 'students', ascending: true);
}
