import 'package:flutter/material.dart';
import 'package:markaz_umaza_hifz_tracker/main.dart';

class Homework extends StatelessWidget {
  const Homework({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              print(await supabase
                  .from('profiles')
                  .select('*, students(*)')
                  .eq('id', supabase.auth.currentUser!.id));
            },
            child: Text("Click Me"),
          )
        ],
      ),
    );
  }
}
