
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  static final String pTitle = 'title';
  static final String pPhone = 'phone';
  static final String pInstagram = 'instagram';
  static final String pUserId = 'userId';

  String? id;
  String title;
  String phone;
  String instagram;
  String userId;

  Store({
    required this.title,
    required this.phone,
    required this.instagram,
     this.userId = '',
    this.id,
  });

  toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[pTitle] = this.title;
    data[pPhone] = this.phone;
    data[pInstagram] = this.instagram;
    return data;
  }

  Store.fromSnap(DocumentSnapshot<Map<String, dynamic>> snap)
      : this(
          title: snap.data()![pTitle],
          phone: snap.data()![pPhone],
          instagram: snap.data()![pInstagram],
          id: snap.reference.id,
        );


  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      title: map[pTitle],
      phone: map[pPhone],
      instagram: map[pInstagram],
      userId: map[pUserId],
    );
  }

//TODO: Passar para o storeprefs (seller)

  Map<String, dynamic> toMapWithReference() {
    return {
      'id': id,
      pTitle: title,
      pPhone: phone,
      pInstagram: instagram,
      pUserId: userId,
    };
  }

  factory Store.fromMapWithReference(Map<String, dynamic> map) {
    return Store(
      title: map[pTitle],
      phone: map[pPhone],
      instagram: map[pInstagram],
      userId: map[pUserId],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Store.fromJson(String source) =>
      Store.fromMapWithReference(json.decode(source));

}
