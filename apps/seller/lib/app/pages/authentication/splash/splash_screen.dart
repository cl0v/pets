import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:seller/app/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //TODO: Load os valores de categorias do firebase(Conferir versão e baixar as categorias)
  @override
  void initState() {
    super.initState();

    UserModel.get().then((user) {
      if (user != null) {
        pushNamed(context, Routes.Home, replace: true);
      } else {
        pushNamed(context, Routes.Login, replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
