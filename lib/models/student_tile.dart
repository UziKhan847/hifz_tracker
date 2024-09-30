// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  final int id;
  final int age;
  final String name;
  final String origin;
  final bool hafiz;

  const StudentTile({
    super.key,
    required this.id,
    required this.age,
    required this.name,
    required this.origin,
    required this.hafiz,
  });

  Expanded studentInfo(
    String textOne,
    textOneData,
    String textTwo,
    textTwoData,
  ) {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('$textOne: $textOneData'),
        Text('$textTwo: $textTwoData'),
      ]),
    );
  }

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
              backgroundColor: const Color.fromARGB(255, 192, 243, 255),
              child: Text("SK"),
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
                    '$name',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  Divider(
                    height: 4,
                  ),
                  Row(
                    children: [
                      studentInfo('Id', id, 'Age', age),
                      studentInfo(
                          'Origin', origin, 'Hafiz', hafiz ? "Yes" : "No"),
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
