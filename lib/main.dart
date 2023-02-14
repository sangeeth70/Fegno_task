import 'package:fegstore/counter_event';
import 'package:fegstore/view/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:fegstore/counter_bloc';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BLoC/timer_cubit.dart';
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerCubit(),
      child: MaterialApp(
        title: 'Fegstore',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

