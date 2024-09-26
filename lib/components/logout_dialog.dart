import 'package:flutter/material.dart';
import 'package:markaz_umaza_hifz_tracker/components/login_signup_snackbar.dart';
import 'package:markaz_umaza_hifz_tracker/supbase_client.dart';

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
                Navigator.pop(context);
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
  TextEditingController? fullnameController,
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
            controller: fullnameController,
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final fullname = fullnameController!.text;
                final userId = id;

                await supabase.from('profile').update({
                  'full_name': fullname,
                }).eq(
                  'id',
                  userId,
                );

                if (context.mounted) {
                  Navigator.pop(context, 'Cancel');
                }
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      });
}
