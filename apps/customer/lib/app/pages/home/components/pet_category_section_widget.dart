import 'package:commons/commons.dart';
import 'package:customer/app/models/categoria_model_helper.dart';
import 'package:flutter/material.dart';
import 'package:customer/app/pages/categoria/categorias_screen.dart';
import 'package:dio/dio.dart';

/// Vai botar em gradiente 2*n as categorias existentes na lista mockedCategoryList
///

class _CategoryBloc {
  final url = Configs.configJsonUrl;
  Future<List<CategoriaModelHelper>> get future async {
    var response = await Dio().get(url);
    List<CategoriaModelHelper> list = response.data
        .map<CategoriaModelHelper>(
          (v) => CategoriaModelHelper.fromMap(v),
        )
        .toList()
          ..sort((a, b) => a.categoria
              .toString()
              .toLowerCase()
              .compareTo(b.categoria.toString().toLowerCase()));
    return list;
  }
}

class PetCategorySectionWidget extends StatelessWidget {
  final _bloc = _CategoryBloc();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Categorias",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          FutureBuilder<List<CategoriaModelHelper>>(
              future: _bloc.future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<CategoriaModelHelper> l = snapshot.data!;
                  return Column(
                    children: l.map(
                      (c) {
                        return CategoriaCard(
                          asset: c.img,
                          color: c.color,
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                          title: c.categoria,
                          onTap: () {
                            push(
                                context,
                                CategoriasScreen(
                                  categoria: c,
                                ));
                          },
                        );
                      },
                    ).toList(),
                  );
                } else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              })
          // ),
        ],
      ),
    );
  }
}

/*
class PetCategorySectionWidget extends StatelessWidget {
  Widget buildPetCategory(
    Category category,
    String total,
    Color color,
    context,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PetCategoryListView(category: category)),
          );
        },
        child: Container(
          height: 80,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[200]!,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Container(
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
                      "assets/images/" +
                          (category == Category.HAMSTER
                              ? "hamster"
                              : category == Category.CAT
                                  ? "cat"
                                  : category == Category.BUNNY
                                      ? "bunny"
                                      : "dog") +
                          ".png",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category == Category.HAMSTER
                        ? "Hamsters"
                        : category == Category.CAT
                            ? "Cats"
                            : category == Category.BUNNY
                                ? "Bunnies"
                                : "Dogs",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(
                  //   "Total of " + total,
                  //   style: TextStyle(
                  //     color: Colors.grey[600],
                  //     fontSize: 14,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pet Category",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Icon(
                Icons.more_horiz,
                color: Colors.grey[800],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildPetCategory(
                      Category.HAMSTER, "56", Colors.orange[200]!, context),
                  buildPetCategory(
                      Category.CAT, "210", Colors.blue[200]!, context),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildPetCategory(
                      Category.BUNNY, "90", Colors.green[200]!, context),
                  buildPetCategory(
                      Category.DOG, "340", Colors.red[200]!, context),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
*/


                  /* GridView(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 130,
                    childAspectRatio: 1 / 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 8,
                  ),
                  children: _bloc.values.map((m) {
                    Categoria categoria = _bloc.categoria(m);
                    return PetCategoryTappableCardWidget(
                      categoria: categoria,
                      // category: pet.title,
                      color: categoria.color,
                      // imgAsset: pet.img,
                      onTap: () {
                        push(
                          context,
                          CategoriasScreen(
                            categoria: categoria,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),*/