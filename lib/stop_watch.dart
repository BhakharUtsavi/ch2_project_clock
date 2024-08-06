import 'dart:async';
import 'package:flutter/material.dart';

class StopClock extends StatefulWidget {
  const StopClock({super.key});

  @override
  State<StopClock> createState() => _StopClockState();
}

class _StopClockState extends State<StopClock> {
  int lastSeconds = 0;
  bool isRunning = false;

  String get formattedTime {
    int hours = lastSeconds ~/ 3600;
    int minutes = (lastSeconds % 3600) ~/ 60;
    int seconds = lastSeconds % 60;
    return '${hours.toString()}:${minutes.toString()}:${seconds.toString()}';
  }

  void tick() {
    if (isRunning) {
      setState(() {
        lastSeconds++;
      });
      Future.delayed(Duration(seconds: 1), tick);
    }
  }

  void _start() {
    if (isRunning) return;
    setState(() {
      isRunning = true;
    });
    tick();
  }

  void _stop() {
    setState(() {
      isRunning = false;
    });
  }

  void _reset() {
    _stop();
    setState(() {
      lastSeconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        title: Text("Stop Watch",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.cyan, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyan,
                    offset: Offset(0, 3),
                    blurRadius: 8,
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(formattedTime,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){_start();}, child: Text("Start",style: TextStyle(color: Colors.cyan))),
                SizedBox(width: 10),
                ElevatedButton(onPressed: (){_reset();}, child: Text("Reset",style: TextStyle(color: Colors.cyan))),
                SizedBox(width: 10),
                ElevatedButton(onPressed: (){_stop();}, child: Text("Stop",style: TextStyle(color: Colors.cyan))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
