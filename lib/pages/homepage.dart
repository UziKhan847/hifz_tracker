import 'package:flutter/material.dart';
import 'package:markaz_umaza_hifz_tracker/components/home_app_bar.dart';
import 'package:markaz_umaza_hifz_tracker/components/speed_dial_menu.dart';
import 'package:markaz_umaza_hifz_tracker/models/student_tile.dart';
import 'package:markaz_umaza_hifz_tracker/supbase_client.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  dynamic _data;
  final String user = supabase.auth.currentUser!.id;

  @override
  void initState() {
    super.initState();
    _data = getData();
  }

  Future getData() async {
    return supabase.from('students').select().eq('parent_id', user);
  }

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
            image: AssetImage("lib/images/school_supplies_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder(
            future: _data,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                final error = snapshot.error;
                return Text('$error');
              } else if (snapshot.hasData) {
                dynamic data = snapshot.data!;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> studentData = data[index];

                    return StudentTile(
                      name: studentData['full_name'],
                      id: studentData['id'],
                      age: studentData['age'],
                      origin: studentData['origin'],
                      hafiz: studentData['hafiz'],
                    );
                  },
                );
              }

              return Center(
                child: SizedBox(
                    height: 60, width: 60, child: CircularProgressIndicator()),
              );
            }),
      ),
      floatingActionButton: SpeedDialMenu(onPressed: () {}),
    );
  }
}
