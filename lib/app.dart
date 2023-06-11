
import 'package:flutter/material.dart';

import './view/timer_page.dart';
class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:TimerPage()
    );
  }
}