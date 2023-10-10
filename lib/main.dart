import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/screen/home_screen.dart';
import 'package:to_do_app/provider/todo_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final String title = 'Todo App';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => TodosProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Color(0xFFf6f5ee),
      ),
        home: ChangeNotifierProvider(

          create: (BuildContext context) {
            (context) => TodosProvider();
          },
          child: MyHomePage(),
        )
    ),
  );
}