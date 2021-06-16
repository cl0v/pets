import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

//TODO: Implementar sharedprefs para a lista de categorias
class CategoryRepository {

  Future<List<CategoriaModelHelper>> get() async {
    final ref =
        FirebaseStorage.instance.ref("jsons/pt_br/categorias.json");
    final url = await ref.getDownloadURL();

    final response = await Dio().get(url);
    final clist = response.data['categories'];
    return clist
        .map<CategoriaModelHelper>((v) => CategoriaModelHelper.fromMap(v))
        .toList()
          ..sort((a, b) => a.categoria
              .toString()
              .toLowerCase()
              .compareTo(b.categoria.toString().toLowerCase()));
  }
}

class CategoriaModelHelper {
  String img;
  String categoria;
  Color color;
  List<EspecieModelHelper> especies;

  CategoriaModelHelper({
    required this.img,
    required this.categoria,
    required this.especies,
    required this.color,
  });

  CategoriaModelHelper.fromMap(Map<String, dynamic> json)
      : this(
          img: json['img'],
          categoria: json['categoria'],
          color: Color(json['color']),
          especies: json['especies']
              .map<EspecieModelHelper>((m) => EspecieModelHelper.fromJson(m))
              .toList(),
        );

  factory CategoriaModelHelper.fromJson(String source) =>
      CategoriaModelHelper.fromMap(json.decode(source));
}

class EspecieModelHelper {
  // late String? img;
  String nome;
  String about;

  EspecieModelHelper(
      {
      // this.img,
      required this.nome,
      required this.about});

  EspecieModelHelper.fromJson(Map<String, dynamic> json)
      : this(
          nome: json['nome'],
          about: json['about'],
        );
}
