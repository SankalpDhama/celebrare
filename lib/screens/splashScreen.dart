import 'dart:async';

import 'package:flutter/material.dart';

import 'AddScreen.dart';
class SplashScreen extends StatefulWidget{

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    super.initState();
    Timer(const Duration(seconds: 2),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
            const AddScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/image.png',width: double.infinity,);
  }
}
