// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:item_registration/Presentation/login_screen.dart';
import 'package:item_registration/Presentation/product_home.dart';
import 'package:item_registration/firebase_options.dart' show DefaultFirebaseOptions;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DefaultFirebaseOptions.currentPlatform;
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ScreenProductHome(),
    debugShowCheckedModeBanner: false,);
  }
}
