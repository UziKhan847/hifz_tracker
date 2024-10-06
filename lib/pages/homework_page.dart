import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_hifz_tracker/extensions/context_extensions.dart';
import 'package:markaz_umaza_hifz_tracker/main.dart';
import 'package:markaz_umaza_hifz_tracker/models/homework/homework.dart';
import 'package:markaz_umaza_hifz_tracker/models/homework/homework_data.dart';
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

  Future<void> updateCompleted(int number) async {
    try {
      await supabase.from('homework').update({
        'completed': true,
      }).eq(
        'homework_number',
        number,
      );

      setState(() {
        homework.homeworkList[number].completed = true;
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
          'Failed! Unexpected error occurred',
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

                homework.homeworkList = homeworkData
                    .where((x) => x.studentId == homework.studentId)
                    .toList();

                return ListView.builder(
                  itemCount: homework.homeworkList.length,
                  itemBuilder: (context, index) {
                    Homework _homework = homework.homeworkList[index];

                    return index < homework.homeworkList.length
                        ? HomeworkTile(
                            homework: _homework,
                            bottomPadding: 0,
                            onPressed: () async {
                              updateCompleted(index);
                              print('IS IT COMPLETE????????????????');
                              print(homework.homeworkList[index].completed);
                            },
                            isSelected: homework.homeworkList[index].completed,
                          )
                        : HomeworkTile(
                            homework: _homework,
                            bottomPadding: 94,
                            onPressed: () async {
                              updateCompleted(index);
                            },
                            isSelected: homework.homeworkList[index].completed,
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
