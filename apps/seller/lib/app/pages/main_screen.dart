import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:seller/app/pages/canil/store_bloc.dart';
import 'package:seller/app/pages/ninhada/ninhada_screen.dart';
import 'package:seller/app/pages/perfil/perfil_screen.dart';
import 'package:seller/app/routes/routes.dart';

import 'authentication/firebase_authentication_repository.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class UserBloc {
  final _repository = UserRepository();
  final IAuthentication _auth = FirebaseAuthenticationRepository();

  Future<UserModel> fetch() async {
    var u = await UserModel.get();
    if (u == null) {
      try {
        var uid = _auth.uid();
        u = await _repository.read(uid!);
        await u.save();
        return u;
      } catch (e) {
        print('mano se n tem uid, como raios logou?');
        throw e;
      }
    } else {
      return u;
    }
  }
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    StoreBloc().fetch().then((c) {
      if (c == null) {
        pushNamed(context, Routes.CadastrarCanil, replace: true);
      }
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
    final body = IndexedStack(
      children: pages,
      index: pageIndex,
    );

    final bNavBar = BottomNavigationBar(
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
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ],
    );

    return Scaffold(
      body: body,
      bottomNavigationBar: bNavBar,
    );
  }
}
