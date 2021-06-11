import 'package:commons/commons.dart';
import 'package:commons/models/product.dart';
import 'package:flutter/material.dart';
import 'package:seller/app/pages/canil/store_prefs.dart';
import 'package:seller/app/routes/routes.dart';
import 'package:seller/app/widgets/commons.dart';

import '../../../constants.dart';
import 'ninhada_bloc.dart';

class NinhadasScreen extends StatefulWidget {
  const NinhadasScreen();
  @override
  _NinhadasScreenState createState() => _NinhadasScreenState();
}

class _NinhadasScreenState extends State<NinhadasScreen> {
  // with AutomaticKeepAliveClientMixin<NinhadasScreen> {
  late final ProductBloc _bloc;

  bool _dataLoaded = false;

  // @override
  // bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    StorePrefs.get().then((c) {
      //Segunda vez que roda parece que ta vindo nullo, após sair do app
      if (c != null) {
        _bloc = ProductBloc(c);
        setState(() {
          _dataLoaded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    deactivate();
  }

  ListTile ninhadaTile(Product ninhada) {
    return ListTile(
      subtitle: Text(ninhada.category.breed),
      title: Text(
        ninhada.title,
      ),
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

    var body = _dataLoaded
        ?
        // Container(
        //     height: size.height,
        //     width: size.width,
        //     child:
        StreamBuilder<List<Product>>(
            stream: _bloc.stream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  var ninhadas = snapshot.data;
                  return ninhadas != null
                      ? ninhadas.isEmpty
                          ? noData
                          : ListView.builder(
                              itemCount: ninhadas.length,
                              itemBuilder: (context, index) {
                                var ninhada = ninhadas[index];
                                return ninhadaTile(ninhada);
                              },
                            )
                      : loadingError;
                case ConnectionState.waiting:
                  return loading;
                default:
                  return loadingError;
              }
            },
            // ),
          )
        : Center(
            child: CircularProgressIndicator(),
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
