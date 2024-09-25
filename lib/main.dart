import 'package:flutter/material.dart';
import 'package:markaz_umaza_hifz_tracker/pages/homepage.dart';
import 'package:markaz_umaza_hifz_tracker/pages/login_signup_page.dart';
import 'package:markaz_umaza_hifz_tracker/supbase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://psukymsclupwiondluqp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBzdWt5bXNjbHVwd2lvbmRsdXFwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjcxMDY4MzQsImV4cCI6MjA0MjY4MjgzNH0.pUfR4Ls2ydYviL5HWnfz5ESe9tASqjFK9rrYY0OHELw',
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    final authSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final User? user = data.session?.user;

      switch (user) {
        case null:
          setState(() {
            isLoggedIn = false;
          });
        default:
          setState(() {
            isLoggedIn = true;
          });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: isLoggedIn ? Homepage() : LoginSignupPage(),
    );
  }
}
