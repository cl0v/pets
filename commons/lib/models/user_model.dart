import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commons/services/shared_local_storage_service.dart';

class UserModel {
  static final String _pref = 'user.prefs';

  static final String pId = 'id';
  static final String pUid = 'uid';
  static final String pNome = 'nome';
  static final String pEmail = 'email';
  static final String pContato = 'contato';

  String id;
  String uid;
  String nome;
  String email;
  String contato;

  UserModel({
    required this.nome,
    required this.email,
    required this.contato,
    this.uid = '',
    this.id = '',
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        uid: json[pUid],
        nome: json[pNome],
        email: json[pEmail],
        contato: json[pContato],
      );

  Map<String, dynamic> toMap() => {
        pUid: uid,
        pNome: nome,
        pEmail: email,
        pContato: contato,
      };

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMapWithReference() => {
        pUid: uid,
        pNome: nome,
        pEmail: email,
        pContato: contato,
        pId: id,
      };

  factory UserModel.fromMapWithReference(Map<String, dynamic> json) =>
      UserModel(
        uid: json[pUid],
        nome: json[pNome],
        email: json[pEmail],
        contato: json[pContato],
        id: json[pId],
      );

  factory UserModel.fromSnap(DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      UserModel.fromMap(snapshot.data()!)..id = snapshot.reference.id;

  factory UserModel.fromJson(String source) =>
      UserModel.fromMapWithReference(json.decode(source));

  static Future<UserModel?> get() async {
    final json = await Prefs.get(_pref);
    if (json != null)
      return json.isEmpty ? null : UserModel.fromJson(json);
    else
      return null;
  }

  Future<void> save() async{
    String json = jsonEncode(toMapWithReference());
    await Prefs.put(_pref, json);
  }

  static clear() {
    Prefs.put(_pref, '');
  }
}
