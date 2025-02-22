import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamestore/pages/home_page.dart';
import 'package:gamestore/main.dart';
import 'package:gamestore/pages/login_page.dart';
import 'package:gamestore/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if(auth.isLoading) {
      return loading();
    } else if(auth.usuario == null) return LoginPage();
    else return HomePage();
  }

  loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
