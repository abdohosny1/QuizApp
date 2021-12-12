import 'package:flutter/material.dart';
import 'package:quiz_test/controler/user_controler.dart';
import 'package:quiz_test/screens/main_menu.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserControler.inilitze();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      home: const MainMenu(),
    );
  }
}
