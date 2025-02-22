import 'package:flutter/material.dart';
import 'package:gamestore/pages/home_page.dart';
import 'package:gamestore/widgets/auth_check.dart';

class Gamestore extends StatelessWidget{
  const Gamestore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GAMESTORE",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo 
      ),
      home: AuthCheck(),
    );
  }
}