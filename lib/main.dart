import 'package:ch2_project_clock/homepage.dart';
import 'package:ch2_project_clock/stop_watch.dart';
import 'package:ch2_project_clock/timer.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/":(context){
          return HomePage();
        },
        "timer":(context){
          return TimerClock();
        },
        "stopwatch":(context){
          return StopClock();
        },
      },
      ),
  );
}