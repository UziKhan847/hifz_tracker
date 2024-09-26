import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:markaz_umaza_hifz_tracker/components/logout_dialog.dart';
import 'package:markaz_umaza_hifz_tracker/supbase_client.dart';

class SpeedDialMenu extends StatelessWidget {
  final void Function()? onPressed;

  const SpeedDialMenu({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      buttonSize: Size(60, 60),
      icon: Icons.menu,
      activeIcon: Icons.close,
      backgroundColor: Color(0xFFE59A2A),
      foregroundColor: Color(0xFFFFFFFF),
      activeBackgroundColor: Color(0xFF123a5e),
      activeForegroundColor: Color(0xFFFFFFFF),
      curve: Curves.fastOutSlowIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.3,
      spaceBetweenChildren: 10,
      childMargin: EdgeInsets.only(right: 5),
      childrenButtonSize: Size(52, 52),
      children: [
        SpeedDialChild(
          child: Icon(Icons.accessibility),
          backgroundColor: Color(0xFFE59A2A),
          foregroundColor: Colors.white,
          label: 'Add Student',
          labelStyle: TextStyle(fontSize: 15.0),
          shape: CircleBorder(),
          onTap: () async {
            final user = supabase.auth.currentUser!.id;
            final data =
                await supabase.from('students').select().eq("parent_id", user);

            print(data);
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.logout),
          backgroundColor: const Color.fromARGB(255, 196, 54, 44),
          foregroundColor: Colors.white,
          label: 'Logout',
          labelStyle: TextStyle(fontSize: 15.0),
          shape: CircleBorder(),
          onTap: () {
            // supabase.auth.signOut();
            // if (context.mounted) {
            //   context.showSnackBar('Logout succesful!');
            // }

            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) => LogoutDialog(),
            // );

            dialogueBuilder(context);
          },
        )
      ],
    );
  }
}
