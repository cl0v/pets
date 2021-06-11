import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:seller/app/pages/canil/store_prefs.dart';
import 'package:seller/app/utils/scaffold_common_components.dart';

class CanilInfoScreen extends StatefulWidget {
  @override
  _CanilInfoScreenState createState() => _CanilInfoScreenState();
}

class _CanilInfoScreenState extends State<CanilInfoScreen> {
  var future = StorePrefs.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: estudar a possibilidade de tirar o ? do store
    var fBuilder = FutureBuilder<Store?>(
      future: future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            Store? store = snapshot.data;
            if (store != null)
              return ListView(
                children: [
                  ListTile(
                    title: Text('Titulo:'),
                    subtitle: Text(
                      store.title,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Contato:'),
                    subtitle: Text(
                      store.phone,
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Instagram:'),
                    subtitle: Text(
                      '${store.instagram}',
                    ),
                  ),
                ],
              );
            else
              return Center(
                child: Text('Nenhum canil cadastrado'),
              );
          default:
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    var appBar = ScaffoldCommonComponents.customAppBar('Loja', () {
      pop(context);
    });

    var result = Scaffold(
      appBar: appBar,
      // drawer: drawer,
      body: fBuilder,
    );

    return result;
  }
}
