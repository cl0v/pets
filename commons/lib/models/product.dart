import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  static final String pImgUrl = 'imgUrl';
  static final String pTitle = 'title';
  static final String pCategory = 'category';
  static final String pApproved = 'approved';
  static final String pStoreId = 'storeId';

  String id; //TODO: Implementar o id(Nao existia antes)
  String imgUrl;
  String title;
  Categoria category;
  bool approved;
  String storeId;
  String? price; //TODO: implement price

  Product({
    this.imgUrl = '',
    this.id = '',
    required this.title,
    required this.category,
    required this.storeId,
    this.approved = true,
  });

  Map<String, dynamic> toMap() {
    return {
      pImgUrl: imgUrl,
      pTitle: title,
      pCategory: category.toMap(),
      pApproved: approved,
      pStoreId: storeId,
    };
  }

//TODO: Acredito que nao preciso do fromMap
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      imgUrl: map[pImgUrl] ?? '',
      title: map[pTitle],
      category: Categoria.fromMap(map[pCategory]),
      storeId: map[pStoreId],
    );
  }

  factory Product.fromSnap(DocumentSnapshot<Map<String, dynamic>> snap) =>
      Product.fromMap(snap.data()!)..id = snap.reference.id;

  @override
  String toString() {
    return 'Product(id: $id, imgUrl: $imgUrl, title: $title, category: $category, approved: $approved, storeId: $storeId, price: $price)';
  }

  Product copyWith({
    String? id,
    String? imgUrl,
    String? title,
    Categoria? category,
    bool? approved,
    String? storeId,
    String? price,
  }) {
    return Product(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      title: title ?? this.title,
      category: category ?? this.category,
      approved: approved ?? this.approved,
      storeId: storeId ?? this.storeId,
    );
  }
}


class Categoria {
  static final String pCategory = 'category';
  static final String pBreed = 'breed';

  String category;
  String breed;

  Categoria({required this.category, required this.breed});

  Categoria.fromMap(Map<String, dynamic> json)
      : this(
          category: json['category'],
          breed: json['breed'],
        );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['breed'] = this.breed;
    return data;
  }
}
