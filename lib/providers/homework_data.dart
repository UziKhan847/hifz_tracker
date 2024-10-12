import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_hifz_tracker/main.dart';
import 'package:markaz_umaza_hifz_tracker/models/homework/homework.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final homeworkData = ChangeNotifierProvider<HomeworkData>((ref) {
  return HomeworkData();
});

class HomeworkData extends ChangeNotifier {
  HomeworkData();

  List<Homework> homeworkList = [];
  int? studentId;

  Future<PostgrestList> getData() async =>
      supabase.from('homework').select().order('date', ascending: false);
}
