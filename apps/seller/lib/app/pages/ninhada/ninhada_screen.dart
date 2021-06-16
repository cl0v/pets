import 'package:commons/commons.dart';
import 'package:commons/models/product.dart';
import 'package:flutter/material.dart';
import 'package:seller/app/routes/routes.dart';
import 'package:seller/app/widgets/commons.dart';

import '../../../constants.dart';
import 'cadastrar_ninhada_screen.dart';
import 'ninhada_bloc.dart';

class NinhadasScreen extends StatefulWidget {
  const NinhadasScreen();
  @override
  _NinhadasScreenState createState() => _NinhadasScreenState();
}

class _NinhadasScreenState extends State<NinhadasScreen> {
  final ProductBloc _bloc = ProductBloc();

  @override
  void initState() {
    super.initState();
    _bloc.init();
  }

  ListTile ninhadaTile(Product p) {
    return ListTile(
      onTap: () {
        push(
          context,
          CreateProductScreen(
            product: p,
          ),
        );
      },
      subtitle: Text(p.category.breed),
      title: Text(
        p.title,
      ),
      trailing: Icon(Icons.edit),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        'Anúncios',
        style: kTitleTextStyle,
      ),
    );

    var body = StreamBuilder<List<Product>>(
      stream: _bloc.productListStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            var ninhadas = snapshot.data!;
            return ListView.builder(
              itemCount: ninhadas.length,
              itemBuilder: (context, index) {
                var ninhada = ninhadas[index];
                return ninhadaTile(ninhada);
              },
            );
          }
          return noData;
        }
        return loading;
      },
      // ),
    );
    final fab = FloatingActionButton.extended(
      // heroTag: 'FabNinhada',
      onPressed: () {
        pushNamed(context, Routes.CadastrarNinhada);
      },
      label: Text('Criar Anúncio'),
      icon: Icon(Icons.add),
    );

    return Scaffold(
      appBar: appBar,
      floatingActionButton: fab,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: body,
    );
  }
}
