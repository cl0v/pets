import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/pages/canil/store_bloc.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_screen.dart';
import 'package:pedigree_seller/app/pages/perfil/perfil_screen.dart';
import 'package:pedigree_seller/app/routes/routes.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _dataLoaded = false;

  @override
  void initState() {
    super.initState();
    UserModel.get().then((u) {
      StoreBloc(u!.id!).get().then((c) async {
        if (c == null) {
          pushNamed(context, Routes.CadastrarCanil, replace: true);
        } else {
          setState(() {
            _dataLoaded = true;
          });
        }
      });
    });
  }

  int pageIndex = 0;

  static const pages = [
    // const CanilScreen(),
    const NinhadasScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final body = _dataLoaded
        ? IndexedStack(
            children: pages,
            index: pageIndex,
          )
        : Center(
            child: CircularProgressIndicator(),
          );

    final bNavBar = _dataLoaded
        ? BottomNavigationBar(
            currentIndex: pageIndex,
            onTap: (i) {
              setState(() {
                pageIndex = i;
              });
            },
            items: [
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.dashboard), label: 'Dashboard'),
              BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Loja'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Perfil'),
            ],
          )
        : Container();

    return Scaffold(
      body: body,
      bottomNavigationBar: bNavBar,
    );
  }
}
