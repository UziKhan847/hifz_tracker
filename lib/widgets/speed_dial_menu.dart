import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:markaz_umaza_hifz_tracker/extensions/context_extensions.dart';

class SpeedDialMenu extends StatelessWidget {
  const SpeedDialMenu({
    super.key,
    required this.onTap,
    required this.onPressedLogout,
  });

  final void Function()? onTap;
  final void Function()? onPressedLogout;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      buttonSize: Size(60, 60),
      icon: Icons.menu,
      activeIcon: Icons.close,
      backgroundColor: Color(0xFFE59A2A),
      foregroundColor: Colors.white,
      activeBackgroundColor: Color(0xFF123a5e),
      activeForegroundColor: Colors.white,
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
          label: 'Update Details',
          labelStyle: TextStyle(fontSize: 15.0),
          shape: CircleBorder(),
          onTap: onTap,
        ),
        SpeedDialChild(
          child: Icon(Icons.logout),
          backgroundColor: const Color.fromARGB(255, 196, 54, 44),
          foregroundColor: Colors.white,
          label: 'Logout',
          labelStyle: TextStyle(fontSize: 15.0),
          shape: CircleBorder(),
          onTap: () {
            context.dialog(
              context: context,
              title: 'Logout',
              content: const Text('Are you sure you want to logout?'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: onPressedLogout,
                  child: const Text('Logout'),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
