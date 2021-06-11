import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:seller/app/pages/authentication/user_model.dart';
import 'package:seller/app/pages/canil/store_bloc.dart';
import 'package:seller/app/pages/canil/store_prefs.dart';
import 'package:seller/app/routes/routes.dart';
import 'package:seller/app/utils/app_bar.dart';
import 'package:seller/app/widgets/commons.dart';


/*
 - Essa página será a dashboard
 - Aqui dentro aparecerá a parte de adicionar reprodutores, pets etc...
*/

class CanilScreen extends StatefulWidget {
  const CanilScreen();
  @override
  _CanilScreenState createState() => _CanilScreenState();
}

class _CanilScreenState extends State<CanilScreen> {
  late final StoreBloc _bloc;

  bool _dataLoaded = false;

  @override
  void dispose() {
    super.dispose();
    _bloc.bloc.dispose();
  }

  //TODO: Criar o push para caso não tenha canil cadastrado

  @override
  void initState() {
    super.initState();

    UserModel.get().then((u) {
      StorePrefs.get().then((c) {
        _bloc = StoreBloc(u!.id!, canil: c!);
        setState(() {
          _dataLoaded = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = customAppBar('Dashboard');

    final noData = Center(
      child: ElevatedButton(
        child: Text('Toque aqui para cadastrar o canil'),
        onPressed: () {
          pushNamed(context, Routes.CadastrarCanil);
        },
      ),
    );

    final msg = Center(
      child: Text(
          'Funcionalidade ainda não está pronta, aguarde mais um pouco...'),
    );

    final body = _dataLoaded
        ? StreamBuilder<Store?>(
            stream: _bloc.bloc.stream,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                  var canil = snapshot.data;
                  if (canil != null) {
                    return msg;
                  } else {
                    return noData;
                  }
                case ConnectionState.waiting:
                  return loading;
                case ConnectionState.done:
                  var canil = snapshot.data;
                  if (canil == null)
                    return noData;
                  else
                    return msg;
                default:
                  return loadingError;
              }
            })
        : Center(
            child: CircularProgressIndicator(),
          );

    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
