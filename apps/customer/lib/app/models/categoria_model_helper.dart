import 'dart:convert';

import 'package:flutter/material.dart';

//HomeScreen tem o exemplo de uso, baixando o json do storage

class CategoriaModelHelper {
  late String img;
  late String categoria;
  late Color color;
  late List<EspecieModelHelper> especies;

  CategoriaModelHelper({
    required this.img,
    required this.categoria,
    required this.especies,
    required this.color,
  });

  CategoriaModelHelper.fromMap(Map<String, dynamic> json) {
    img = json['img'];
    categoria = json['categoria'];
    color = Color(json['color']);
    especies = json['especies']
        .map<EspecieModelHelper>((m) => EspecieModelHelper.fromJson(m))
        .toList();
  }


  factory CategoriaModelHelper.fromJson(String source) => CategoriaModelHelper.fromMap(json.decode(source));
}

class EspecieModelHelper {
  late String? img;
  late String nome;

  EspecieModelHelper({this.img, required this.nome});

  EspecieModelHelper.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    nome = json['nome'];
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EspecieModelHelper &&
      other.img == img &&
      other.nome == nome;
  }

  @override
  int get hashCode => img.hashCode ^ nome.hashCode;
}




