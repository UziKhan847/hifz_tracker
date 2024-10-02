import 'package:flutter/material.dart';
import 'package:markaz_umaza_hifz_tracker/extensions/context_extensions.dart';
import 'package:markaz_umaza_hifz_tracker/main.dart';

Future<void> dialogueBuilder(BuildContext context) {
  return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                supabase.auth.signOut();
                if (context.mounted) {
                  context.showSnackBar('Logout succesful!');
                }
              },
              child: const Text('Logout'),
            ),
          ],
        );
      });
}

Future<void> dialogueBuilderTwo(
  BuildContext context,
  TextEditingController fullNameController,
  String id,
) {
  return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Please Enter Full Name',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          content: TextField(
            controller: fullNameController,
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final fullName = fullNameController.text;
                final userId = id;

                await supabase.from('profiles').update({
                  'full_name': fullName,
                }).eq(
                  'id',
                  userId,
                );

                if (context.mounted) {
                  Navigator.pop(context, 'Cancel');
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      });
}

Future<void> dialogueBuilderThree(
  BuildContext context,
  void Function()? onPressed,
  TextEditingController idController,
  TextEditingController fullNameController,
  TextEditingController ageController,
  TextEditingController originController,
  TextEditingController hafizController,
) {
  return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Please Enter Full Name',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          content: Column(
            children: [
              TextField(
                controller: idController,
                decoration: InputDecoration(labelText: 'Id Number'),
              ),
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextField(
                controller: originController,
                decoration: InputDecoration(labelText: 'Origin'),
              ),
              TextField(
                controller: hafizController,
                decoration: InputDecoration(labelText: 'Is he Hafiz?'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: onPressed,
              child: const Text('Add'),
            ),
          ],
        );
      });
}
