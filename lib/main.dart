import 'package:firebase_core/firebase_core.dart';
import 'package:shopping_app/pages/AuthPage.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/HomePage.dart';
import 'package:shopping_app/models/product_model.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override


  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
            color: Colors.black,
          ),
        ),
        home: AuthScreen(),
      );});
    }
}