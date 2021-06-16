import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'app/pages/store_screen.dart';
  bool useEmulator = false;
  bool firstRun = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  if (kDebugMode && useEmulator) {
    String host = defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2:8080'
        : 'localhost:8080';

    if (firstRun) {
      FirebaseFirestore.instance.settings = Settings(
        host: host,
        sslEnabled: false,
      );
    }

    await FirebaseStorage.instance.useEmulator(host: 'localhost', port: 9199);

    // FirebaseAuth.instance.useEmulator('http://localhost:9099');
  }

  runApp(Pedigree());
}

class Pedigree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedigree Vendedor',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.Home,
      routes: routes,
    );
  }
}

abstract class Routes {
  static const Home = '/';
}

final routes = <String, WidgetBuilder>{
  Routes.Home: (context) => StoreListScreen(),
};
