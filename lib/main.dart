import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:novaji/screens/home_page.dart';
import 'package:novaji/screens/login_page.dart';
import 'package:novaji/screens/register_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      // home: const HomePage()
      home: Login(),

    );
  }
}
