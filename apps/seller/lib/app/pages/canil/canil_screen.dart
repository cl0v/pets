import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:seller/app/pages/canil/store_bloc.dart';
import 'package:seller/app/pages/canil/store_prefs.dart';
import 'package:seller/app/routes/routes.dart';
import 'package:seller/app/utils/app_bar.dart';
import 'package:seller/app/widgets/commons.dart';

/*
 - Essa página será a dashboard
 - Aqui dentro aparecerá a parte de adicionar reprodutores, pets etc...
*/

class CanilScreen extends StatefulWidget {
  const CanilScreen();
  @override
  _CanilScreenState createState() => _CanilScreenState();
}

class _CanilScreenState extends State<CanilScreen> {


  @override
  Widget build(BuildContext context) {
    final appBar = customAppBar('Dashboard');

    final msg = Center(
      child: Text(
          'Funcionalidade ainda não está pronta, aguarde mais um pouco...'),
    );

    return Scaffold(
      appBar: appBar,
      body: msg,
    );
  }
}
