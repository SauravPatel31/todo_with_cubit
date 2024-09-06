import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_cubit/data/dbhelper.dart';
import 'package:todo_with_cubit/todo_cubit.dart';
import 'package:todo_with_cubit/view/home_page.dart';

void main() {
  runApp( BlocProvider(
      create: (context) => TodoCubit(dBhelperl: DBhelper.getInstance()),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}


