import 'package:flutter/material.dart';
import 'package:invoice_generator_app/routes/All_Routes.dart';
void main()
{
  runApp(
    const Myapp(),
  );
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AllRoutes.splashpage,
      routes: AllRoutes.routes,
    );
  }
}
