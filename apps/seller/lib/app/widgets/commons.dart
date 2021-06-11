import 'package:flutter/material.dart';

final Center loading = Center(
  child: CircularProgressIndicator(),
);

final Center loadingError = Center(
  child: Text('Ocorreu um erro, tente novamente mais tarde'),
);

final Center noData = Center(
      child: Text("Nenhum cadastrado ainda. Toque no '+' para cadastrar"),
    );
    