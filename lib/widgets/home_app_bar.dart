import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFca8925),
      foregroundColor: Color(0xFFFFFFFF),
      shadowColor: Color(0xFF000000),
      elevation: 5,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        'Student List',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
      ),
    );
  }
}
