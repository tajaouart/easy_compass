import 'package:flutter/material.dart';
import 'package:easy_compass/easy_compass.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Compass Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const CompassPage(),
    );
  }
}

class CompassPage extends StatefulWidget {
  const CompassPage({Key? key}) : super(key: key);

  @override
  CompassPageState createState() => CompassPageState();
}

class CompassPageState extends State<CompassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Easy Compass App'),
      ),
      body: Center(
        child: StreamBuilder<CompassEvent>(
          stream: EasyCompass().stream,
          builder: (context, snapshot) {
            final heading = snapshot.data?.heading ?? 0;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(heading + 180) % 360 - 180}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.2,
                ),
                Transform.rotate(
                  angle: -heading * (math.pi / 180),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset('assets/compass.jpg'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
