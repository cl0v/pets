
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  static final String pTitle = 'title';
  static final String pPhone = 'phone';
  static final String pInstagram = 'instagram';
  static final String pUserId = 'userId';

  String id;
  String title;
  String phone;
  String instagram;
  String userId;

  Store({
    required this.title,
    required this.phone,
    required this.instagram,
     this.userId = '',
    this.id = '',
  });

  toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[pTitle] = this.title;
    data[pPhone] = this.phone;
    data[pInstagram] = this.instagram;
    data[pUserId] = this.userId;
    return data;
  }

  Store.fromSnap(DocumentSnapshot<Map<String, dynamic>> snap)
      : this(
          title: snap.data()![pTitle],
          phone: snap.data()![pPhone],
          instagram: snap.data()![pInstagram],
          userId: snap.data()![pUserId],
          id: snap.reference.id,
        );


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

  factory Store.fromJson(String source) =>
      Store.fromMapWithReference(json.decode(source));


  @override
  String toString() {
    return 'Store(id: $id, title: $title, phone: $phone, instagram: $instagram, userId: $userId)';
  }
}
