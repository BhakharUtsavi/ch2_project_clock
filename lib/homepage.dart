import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DateTime dateTime = DateTime.now();
  int hour=0,minute=0,second=0;

  void start(){
    Timer.periodic(const Duration(seconds: 1),(timer){
      hour=DateTime.now().hour;
      minute=DateTime.now().minute;
      second=DateTime.now().second;

      if(hour>=12)
      {
        hour-=12;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    hour=dateTime.hour;
    minute=dateTime.minute;
    second=dateTime.second;
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page",
          style: TextStyle(
            color:Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

    drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage("https://img.freepik.com/premium-vector/avatar-icon001_750950-50.jpg?w=2000"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("timer",arguments: "Timer");
              },
              child: const Text("Timer",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("stopwatch",arguments: "Stop Watch");
              },
              child: const Text("Stop Watch",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Transform.scale(
                  scale: 5,
                  child: CircularProgressIndicator(
                    value: second/60,
                    color: Colors.cyan,
                  ),
                ),

                Transform.scale(
                  scale: 3,
                  child: CircularProgressIndicator(
                    value: minute /60,
                    color: Colors.tealAccent,
                  ),
                ),

                Transform.scale(
                  scale: 1,
                  child: CircularProgressIndicator(
                    value: hour/12,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),

            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:Border.all(color: Colors.black),
                  ),
                  child: Transform.rotate(
                    angle: (2*pi)*(second/60)+(pi/2),
                    child: const Divider(
                      thickness: 3,
                      indent: 10,
                      endIndent: 100,
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:Border.all(color: Colors.black),
                  ),
                  child: Transform.rotate(
                    angle: (2*pi)*(minute/60)+(pi/2),
                    child: const Divider(
                      color: Colors.black,
                      thickness: 3,
                      indent: 25,
                      endIndent: 100,
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:Border.all(color: Colors.black),
                  ),
                  child: Transform.rotate(
                    angle: (2*pi)*(hour/12)+(pi/2),
                    child: const Divider(
                      color: Colors.green,
                      thickness: 3,
                      indent: 45,
                      endIndent: 100,
                    ),
                  ),
                ),
              ],
            ),

            Text("$hour : $minute : $second",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
