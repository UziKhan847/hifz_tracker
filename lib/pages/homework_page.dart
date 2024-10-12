import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_hifz_tracker/extensions/context_extensions.dart';
import 'package:markaz_umaza_hifz_tracker/main.dart';
import 'package:markaz_umaza_hifz_tracker/models/homework/homework.dart';
import 'package:markaz_umaza_hifz_tracker/providers/homework_data.dart';
import 'package:markaz_umaza_hifz_tracker/models/homework/homework_tile.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/home_app_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeworkPage extends ConsumerStatefulWidget {
  const HomeworkPage({super.key});

  @override
  ConsumerState<HomeworkPage> createState() => _HomeworkPageState();
}

class _HomeworkPageState extends ConsumerState<HomeworkPage> {
  late HomeworkData homework;
  late final data = homework.getData();

  Future<void> markComplete(int id, int index) async {
    try {
      await supabase.from('homework').update({
        'is_completed': true,
      }).eq(
        'id',
        id,
      );

      setState(() {
        homework.homeworkList[index].isCompleted = true;
      });

      if (mounted) {
        context.showSnackBar("Marked as Completed!");
      }

      if (mounted) {
        Navigator.pop(context, 'Cancel');
      }
    } catch (error) {
      if (mounted) {
        context.showSnackBar(
          "$error",
          isError: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    homework = ref.watch(homeworkData);

    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
      appBar: HomeAppBar(
        automaticallyImplyLeading: true,
        title: "Homework",
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
                final homeworkData =
                    snapshot.data!.map(Homework.fromJson).toList();

                if (homework.homeworkList.isEmpty) {
                  homework.homeworkList = homeworkData;
                }

                final studentHomeworkList = homework.homeworkList
                    .where((x) => x.studentId == homework.studentId)
                    .toList();

                return ListView.builder(
                  itemCount: studentHomeworkList.length,
                  itemBuilder: (context, index) {
                    Homework studentHomework = studentHomeworkList[index];

                    int indexOfStudentId = homework.homeworkList
                        .indexWhere((e) => e.id == studentHomework.id);

                    return HomeworkTile(
                      homework: studentHomework,
                      bottomPadding:
                          index < studentHomeworkList.length ? 0 : 94,
                      onPressed: () async {
                        await markComplete(
                            studentHomework.id, indexOfStudentId);
                      },
                      isSelected: studentHomeworkList[index].isCompleted,
                    );
                  },
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
