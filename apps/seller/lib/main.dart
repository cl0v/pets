import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pedigree_seller/pedigree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



/** 
 * Criar a dashboard
 * Altere o nome das coisas
 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  bool useEmulator = false;
  bool firstRun = true;


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

    FirebaseAuth.instance.useEmulator('http://localhost:9099');
  }

  runApp(Pedigree());
}

/*//TODO: O que fazer antes de ir para o servidor ou outro app
->> Materiais de estudo flutter/gallery no github
- Corrigir ImagePicker
- ImagePicker vai comunicar com o Controller
- Adicionar a pagina do pet para vizualizar como ficará na página do aplicativo
- Pagina da lista de ninhada (botao (...) será criado como um menuButton)
*/

//TODO: Criar cadastro do canil
//TODO: Terminar o cadastro do usuário

//TODO: Use modelos e variaveis em ptBr, vai evitar perder tempo pensando em ing

//TODO: Fazer a splash screen do pedigree (logo) ser uma hero com a loginscreen

//TODO: Posso verificar cnpj e cpf por aqui(alguma api)
//ou posso fazer pelo cloud funcitons
//Por aqui existem riscos 
//TODO: Aguardar aprovação do canil (Fazer isso automaticamente mais tarde)
// (Provavelmente com cloud functions)

//Sellers pode ser uma extencao de users, porem com alguns provilegios


//http://localhost:9199/v0/b/pedigree-app-5cfbe.appspot.com/o/canil%2FoUZAZiyNtSMF
//IKPYfpur%2Fninhadas%2FS9FWpHRDliJ9jjeR3TcG%2Fcat_4.jpg?alt=media&token=4a57856a-
//12e0-45e8-a112-1ebc497d208a

//http://localhost:9199/v0/b/pedigree-app-5cfbe.appspot.com/o/canil%2FoUZAZiyNtSM
//FIKPYfpur%2Fninhadas%2Fff4oxcTZjIHQkja98pfH%2Fdog_4.jpg?alt=media&token=e657a139
//-1745-4eda-9882-a18ce2454bcf
