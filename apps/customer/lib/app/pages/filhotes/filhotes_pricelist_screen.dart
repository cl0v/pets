import 'package:flutter/material.dart';
import 'package:pedigree/app/pages/detalhes/detalhes_screen.dart';
import 'package:commons/commons.dart';

import 'components/preco_filhote_card.dart';
import 'filhote_bloc.dart';

class FilhotesListViewScreen extends StatefulWidget {
  final CategoriaFilhote categoria;

  FilhotesListViewScreen({
    required this.categoria,
  });

  @override
  _FilhotesListViewScreenState createState() => _FilhotesListViewScreenState();
}

class _FilhotesListViewScreenState extends State<FilhotesListViewScreen> {
  final _bloc = FilhoteBloc();

  @override
  void initState() {
    super.initState();
    _bloc.byCategoria(
      widget.categoria,
    );
    // filhotesByCategoria
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoria.breed,
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
        child: StreamBuilder<List<Product>>(
            stream: _bloc.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> petList = snapshot.data!;
                return GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 280,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  children: petList
                      .map(
                        (pet) => PrecoFilhoteCard(
                          pet: pet,
                          onTap: () {
                            push(
                              context,
                              DetalhesScreen(pet: pet),
                            );
                          },
                        ),
                      )
                      .toList(),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

/* Basic filter

  Widget buildFilter(String name, bool selected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border.all(
          width: 1,
          color: selected ? Colors.transparent : Colors.grey[300]!,
        ),
        boxShadow: [
          BoxShadow(
            color: selected ? Colors.blue[300]!.withOpacity(0.5) : Colors.white,
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
        color: selected ? Colors.blue[300] : Colors.white,
      ),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : Colors.grey[800],
            ),
          ),
          selected
              ? Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
*/