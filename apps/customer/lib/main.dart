import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app.dart';
//TODO: A descricao da especie deve aparecer quando mostrar todos for selecionado
//TODO: Adicionar as categorias, e deixar que a coisa cresca naturalmente

/* TODO
>> página de detalhes<<
- Remover o sobre bugado da página de dog
- Remover o sobre o canil bugado da página de dog
- As features da página de detalhes nao estao implementadas
- Está cortando a foto do bicho na página de detalhes
*/

//TODO:Adicionar categorias


bool firstRun = false;
bool useEmulator = false;

Future<void> main() async {
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
  }
  runApp(MyApp());
}
