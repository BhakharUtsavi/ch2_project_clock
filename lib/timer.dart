// import 'dart:async';
// import 'package:flutter/material.dart';
//
// class TimerClock extends StatefulWidget {
//   const TimerClock({super.key});
//
//   @override
//   State<TimerClock> createState() => _TimerClockState();
// }
//
// class _TimerClockState extends State<TimerClock> {
//
//   DateTime dateTime = DateTime.now();
//   int hour = 0, minute = 0, second = 0;
//   bool isRun = false;
//   int remainder=60;
//
//   void update() {
//
//     if (isRun) {
//       remainder--;
//       setState(() {
//         dateTime = DateTime.now();
//         hour = dateTime.hour;
//         minute = dateTime.minute;
//         second = dateTime.second;
//
//         if (hour >= 12) {
//           hour -= 12;
//         }
//       });
//       Future.delayed(Duration(seconds: 1), update);
//     }
//   }
//
//   void start() {
//     isRun = true;
//     update();
//   }
//
//   void stop() {
//     isRun = false;
//   }
//
//   void reset() {
//     stop();
//     setState(() {
//       hour = 0;
//       minute = 0;
//       second = 0;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     String contact = ModalRoute.of(context)!.settings.arguments as String;
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         title: Text("Stop Watch",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: 60,
//                   width: 250,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     border: Border.all(color: Colors.green, width: 2),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.green,
//                         offset: Offset(3, 3),
//                         blurRadius: 5,
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 77, right: 77, top: 10),
//                   child: Text("$hour : $minute : $second",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(onPressed: start, child: Text("Start")),
//                 ElevatedButton(onPressed: reset, child: Text("Reset")),
//                 ElevatedButton(onPressed: stop, child: Text("Stop")),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';

class TimerClock extends StatefulWidget {
  const TimerClock({super.key});

  @override
  State<TimerClock> createState() => _TimerClockState();
}

class _TimerClockState extends State<TimerClock> {
  Timer? _timer;
  int _remainingSeconds = 3600;

  String get _formattedTime {
    int hours = _remainingSeconds ~/ 3600;
    int minutes = (_remainingSeconds % 3600) ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${hours.toString()}:${minutes.toString()}:${seconds.toString()}';
  }
  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }
  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }
  void _resetTimer() {
    _stopTimer();
    setState(() {
      _remainingSeconds = 0;
    });
  }
  Future<void> _selectMinutes() async {
    TextEditingController controller = TextEditingController();
    int? selectedMinutes;
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter minutes'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter number of minutes',
            ),
            onChanged: (value) {
              selectedMinutes = int.tryParse(value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Set'),
            ),
          ],
        );
      },
    );
    if (selectedMinutes != null) {
      setState(() {
        _remainingSeconds = selectedMinutes! * 60;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        title: Text("Countdown Timer",
          style: TextStyle(
            color: Colors.white,
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
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyan,
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Center(
                child: Text(_formattedTime,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){_selectMinutes();}, child: Text("Set Time")),
                SizedBox(width: 10),
                ElevatedButton(onPressed: (){_startTimer();}, child: Text("Start")),
                SizedBox(width: 10),
                ElevatedButton(onPressed: (){_resetTimer();}, child: Text("Reset")),
                SizedBox(width: 10),
                ElevatedButton(onPressed: (){_stopTimer();}, child: Text("Stop")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}