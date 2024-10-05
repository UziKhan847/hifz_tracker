// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:markaz_umaza_hifz_tracker/models/student/student.dart';
import 'package:markaz_umaza_hifz_tracker/utils/margins.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    super.key,
    required this.student,
    required this.bottomPadding,
    required this.onTap,
  });

  final Student student;
  final double bottomPadding;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
            top: 24, right: 24, left: 24, bottom: bottomPadding),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFF123a5e),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ]),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ID#:',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.5,
                          color: Colors.white)),
                  Text('${student.id}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.5,
                          color: Colors.white)),
                ],
              ),
              Margins.horizontal16,
              Container(
                width: 250,
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 9),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      student.fullName,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16.5),
                    ),
                    Divider(
                      height: 0,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text('DOB: ${student.age}',
                                style: TextStyle(fontSize: 15))),
                        Expanded(
                            child: Text(
                                'Hafiz: ${student.hafiz ? "Yes" : "No"}',
                                style: TextStyle(fontSize: 15))),
                        Margins.vertical2,

                        // Expanded(
                        //   child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text('Id: ${student.id}'),
                        //         Text('Age: ${student.age}'),
                        //       ]),
                        // ),
                        // Expanded(
                        //   child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text('Origin: ${student.origin}'),
                        //         Text('Hafiz: ${student.hafiz ? "Yes" : "No"}'),
                        //       ]),
                        // ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text('Origin: ${student.origin}',
                                style: TextStyle(fontSize: 15))),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
