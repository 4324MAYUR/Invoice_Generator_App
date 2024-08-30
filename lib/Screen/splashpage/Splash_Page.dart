import 'package:flutter/material.dart';
import 'package:invoice_generator_app/routes/All_Routes.dart';
class Splash_Page extends StatelessWidget {
  const Splash_Page({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 5),
        () {
  Navigator.of(context).pushReplacementNamed(AllRoutes.homepage);
},
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          width: double.infinity,
          color: Colors.grey,
          height: double.infinity,
        ),
      ),
    );
  }
}
