import 'package:commons/commons.dart';
import 'package:customer/app/models/categoria_model_helper.dart';
import 'package:customer/app/pages/filhotes/filhotes_pricelist_screen.dart';
import 'package:flutter/material.dart';

class CategoriasScreen extends StatelessWidget {
  final CategoriaModelHelper categoria;

  const CategoriasScreen({
    Key? key,
    required this.categoria,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoria.categoria,
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
        leading: BackButton(
          color: Colors.grey[800],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: categoria.especies
              .map(
                (e) => CategoriaCard(
                    asset: categoria.img,
                    color: categoria.color,
                    title: e.nome,
                    onTap: () {
                      push(
                        context,
                        FilhotesListViewScreen(
                            categoria: CategoriaFilhote(
                          category: categoria.categoria,
                          breed: e.nome,
                        )),
                      );
                    }),
              )
              .toList(),
        ),
      ),
    );
  }
}

class CategoriaCard extends StatelessWidget {
  const CategoriaCard({
    Key? key,
    required this.onTap,
    required this.asset,
    required this.color,
    required this.title,
    // this.padding = const EdgeInsets.all(12),
    this.padding,
  }) : super(key: key);

  final String asset;
  final Color color;
  final String title;
  final VoidCallback onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final img = Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.5),
      ),
      child: Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: Image.asset(
            asset,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );

    return Card(
      child: ListTile(
        onTap: onTap,
        trailing: Icon(Icons.arrow_forward_ios),
        contentPadding: padding,
        leading: img,
        title: Text(title),
      ),
    );
  }
}
