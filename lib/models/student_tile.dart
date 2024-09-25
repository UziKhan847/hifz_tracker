// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 22, left: 22),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFF123a5e),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2))
            ]),
        height: 105,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              child: Text("SK"),
              backgroundColor: const Color.fromARGB(255, 192, 243, 255),
            ),
            Container(
              height: 80,
              width: 240,
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(1),
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(1),
                      spreadRadius: -1,
                      blurRadius: 2,
                      offset: Offset(0, 0),
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Mohammad Sudais Khan',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  Divider(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Id: 1'),
                              Text('Age: 13'),
                            ]),
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Origin: Canada'),
                              Text('Hafiz: No'),
                            ]),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
