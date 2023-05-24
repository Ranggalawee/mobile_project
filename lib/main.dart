import 'package:flutter/material.dart';
import 'package:finalmobile/loginpage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:finalmobile/user.dart';

String boxName = 'USER';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<UserModel>(UserModelAdapter());
  await Hive.openBox<UserModel>(boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Volcano',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const LoginPage(),
    );
  }
}


