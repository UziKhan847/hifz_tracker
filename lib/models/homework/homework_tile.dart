import 'package:flutter/material.dart';
import 'package:markaz_umaza_hifz_tracker/models/homework/homework.dart';
import 'package:markaz_umaza_hifz_tracker/utils/margins.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/dialog/dialog.dart';
import 'package:markaz_umaza_hifz_tracker/widgets/labeled_checkbox.dart';

class HomeworkTile extends StatefulWidget {
  const HomeworkTile(
      {super.key,
      required this.homework,
      required this.bottomPadding,
      required this.onPressed,
      required this.isSelected});

  final Homework homework;
  final double bottomPadding;
  final void Function()? onPressed;
  final bool isSelected;

  @override
  State<HomeworkTile> createState() => _HomeworkTileState();
}

class _HomeworkTileState extends State<HomeworkTile> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 24, right: 22, left: 22, bottom: widget.bottomPadding),
      child: Container(
        height: 170,
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Date Assigned: ${widget.homework.date}"),
            Divider(
              height: 0,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Homework #: ${widget.homework.hwNumber}'),
                      Margins.vertical10,
                      Text('Sabaq: ${widget.homework.sabaq}'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Page #: ${widget.homework.pageNumber}'),
                      Margins.vertical10,
                      Text('Juzu #: ${widget.homework.juzuNumber}'),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Text('Performance: ${widget.homework.performance}')),
                VerticalDivider(),
                SizedBox(
                  width: 120,
                  child: LabeledCheckbox(
                    label: widget.isSelected
                        ? Text('Completed',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                            ))
                        : Text('Completed'),
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    value: widget.isSelected,
                    onChanged: (bool newValue) {
                      if (widget.isSelected == false) {
                        DialogMenu(
                          title: 'Do you want to mark as completed?',
                          content: Text('Warning, this cannot be undone!'),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: widget.onPressed,
                                  child: const Text('Yes'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (context.mounted) {
                                      Navigator.pop(context, 'Cancel');
                                    }
                                  },
                                  child: const Text('No'),
                                ),
                              ],
                            ),
                          ],
                        ).dialogueBuilder(context);
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
