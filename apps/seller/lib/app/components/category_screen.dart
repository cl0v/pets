import 'dart:convert';

import 'package:commons/commons.dart';
import 'package:flutter/material.dart';


import '../../constants.dart';

//final url =
//    'http://localhost:9199/v0/b/pedigree-app-5cfbe.appspot.com/o/jsons%2Fpt_br%2Fcategorias.json?alt=media&token=776ad2d1-1e10-4635-8219-9eb008a7ea54';

class CategoriaModelHelper {
  late String categoria;
  late List<EspecieModelHelper> especies;

  CategoriaModelHelper({
    required this.categoria,
    required this.especies,
  });

  CategoriaModelHelper.fromMap(Map<String, dynamic> json) {
    categoria = json['categoria'];
    especies = json['especies']
        .map<EspecieModelHelper>((m) => EspecieModelHelper.fromJson(m))
        .toList();
  }

  factory CategoriaModelHelper.fromJson(String source) =>
      CategoriaModelHelper.fromMap(json.decode(source));
}

class EspecieModelHelper {
  late String nome;

  EspecieModelHelper({
    required this.nome,
  });

  EspecieModelHelper.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
  }
}

class CategorySelectorScreen extends StatelessWidget {
  final List<CategoriaModelHelper> categorias;
  final List<EspecieModelHelper>? especies;
  final String title;
  final Function(String, String) onChanged;
  final String routeBack;

  CategorySelectorScreen({
    required this.title,
    required this.onChanged,
    required this.routeBack,
    this.categorias = const [],
    this.especies = const [],
  });

  @override
  Widget build(BuildContext context) {
    final List<String> list = especies?.map((e) => e.nome).toList() ?? categorias.map((c) => c.categoria).toList();

    var appBar = AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: kTitleTextStyle,
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey[800],
            ),
            onPressed: () => Navigator.pop(context),
          );
        },
      ),
    );
    var body = ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, idx) {
          final txt = list[idx];
          return ListTile(
            title: Text(
              txt,
            ),
            trailing: especies == null ? Icon(Icons.arrow_forward_ios) : null,
            onTap: () {
              if (especies == null) {
                push(
                    context,
                    CategorySelectorScreen(
                        title: categorias[idx].categoria,
                        onChanged: onChanged,
                        routeBack: routeBack,
                        especies: categorias[idx].especies));
              }
              else {
                onChanged(title, txt);
                popUntil(context, routeBack);
              }
            },
          );
        });
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
