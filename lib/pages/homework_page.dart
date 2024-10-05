import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  Widget build(BuildContext context) {
    homework = ref.watch(homeworkData);

    return Scaffold(
      backgroundColor: Color(0xFFFDFDFD),
      appBar: HomeAppBar(
        title: 'Hoemework',
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
                          )
                        : HomeworkTile(
                            homework: _homework,
                            bottomPadding: 94,
                          );
                  },
                );
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(onPressed: null),
    );
  }
}
