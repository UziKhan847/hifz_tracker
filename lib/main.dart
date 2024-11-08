import 'dart:async';

import 'package:flutter/material.dart';
import 'package:markaz_umaza_hifz_tracker/keys.dart';
import 'package:markaz_umaza_hifz_tracker/pages/homepage.dart';
import 'package:markaz_umaza_hifz_tracker/pages/homework_page.dart';
import 'package:markaz_umaza_hifz_tracker/pages/login_signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final supabase = Supabase.instance.client;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrlKey,
    anonKey: supabaseAnonKey,
  );

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: supabase.auth.onAuthStateChange,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Oops! Something went wrong, please try again'));
            }

            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data?.session == null) {
              return LoginSignupPage();
            }

            return Homepage();
          }),
      routes: {
        '/homework': (context) => HomeworkPage(),
      },
    );
  }
}
