import 'package:flutter/material.dart';
import 'package:pedigree/app/models/categoria_model_helper.dart';

class CategoriaCard extends StatelessWidget {
  final VoidCallback onTap;
  final EspecieModelHelper especie;


  CategoriaCard({
    required this.onTap,
    required this.especie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
        margin: EdgeInsets.only(right: 8),
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  // image: DecorationImage(
                    // image: AssetImage(especie.img),
                    // fit: BoxFit.cover,
                  // ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                especie.nome,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
