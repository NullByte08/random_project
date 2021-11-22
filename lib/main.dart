import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_project/home_page.dart';
import 'package:random_project/models/application_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      child: const MyApp(),
      create: (c) => ApplicationModel(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
