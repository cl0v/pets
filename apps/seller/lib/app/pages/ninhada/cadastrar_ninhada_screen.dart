import 'package:commons/models/product.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:seller/app/components/category_screen.dart';
import 'package:seller/app/pages/canil/store_prefs.dart';
import 'package:seller/app/pages/ninhada/ninhada_bloc.dart';
import 'package:seller/app/routes/routes.dart';
import 'package:seller/app/utils/scaffold_common_components.dart';
import 'package:dio/dio.dart';

import 'package:commons/commons.dart';

//TODO: Remover reprodutor

class _CategoryBloc {
  final url = Configs.configJsonUrl;
  Future<List<CategoriaModelHelper>> future() async {
    Dio()
        .get(
            "https://firebasestorage.googleapis.com/v0/b/pedigree-app-5cfbe.appspot.com/o/jsons%2Fpt_br%2Fcategorias.json?alt=media&token=33aa2be0-c2d5-4b63-92d9-04dce8d74297")
        .then((value) => print(value));
    var response = await Dio().get(url);
    print(response.data);
    return response.data
        .map<CategoriaModelHelper>((v) => CategoriaModelHelper.fromMap(v))
        .toList();
  }
}

class CadastrarNinhadaScreen extends StatefulWidget {
  @override
  _CadastrarNinhadaScreenState createState() => _CadastrarNinhadaScreenState();
}

class _CadastrarNinhadaScreenState extends State<CadastrarNinhadaScreen> {
  late final ProductBloc _bloc;
  final _CategoryBloc _categoryBloc = _CategoryBloc();
  late final String storeId;

  bool _loadedData = false;

  @override
  void initState() {
    super.initState();
    StorePrefs.get().then((c) {
      if (c != null) {
        storeId = c.id!;
        _bloc = ProductBloc(c);
      }
      setState(() {
        _loadedData = true;
      });
    });
  }

  final _tTitulo = TextEditingController();

  CategoriaFilhote? _categoria;

  @override
  dispose() {
    super.dispose();
    _bloc.createBtnBloc.dispose();
  }

  _setCategory(String categoria, String especie) {
    setState(() {
      _categoria = CategoriaFilhote(
        category: categoria,
        breed: especie,
      );

      //TODO: Quando troca a categoria pela segunda vez, nao atualiza as opções
    });
  }

  bool _continue = true;

  //TODO: Fazer as validações
  _onCreatePressed() async {
    //TODO: Se eu tentar cadastrar sem a foto, pode dar biziu
    if (_tTitulo.text == '' || _categoria == null)
      return alert(context, 'Por favor preencha todos os campos');
    if (foto != null && _categoria != null) {
      Product ninhada = Product(
        title: _tTitulo.text,
        storeId: storeId,
        category: _categoria!,
      );

      await _bloc.create(
        foto!,
        ninhada,
      );

      pop(context);
    } else
      alert(context, 'Não foi possivel cadastrar, pois voce nao enviou imagem');
  }

  PlatformFile? foto;
  _onFotoChanged(PlatformFile foto) {
    this.foto = foto;
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavBar = _loadedData
        ? StreamBuilder(
            stream: _bloc.createBtnBloc.stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return ScaffoldCommonComponents.customBottomAppBar(
                'Continuar',
                _continue ? _onCreatePressed : null,
                context,
                snapshot.data ?? false,
              );
            },
          )
        : Container();
    var appBar = ScaffoldCommonComponents.customAppBar(
      'Novo',
      () => pop(context),
    );
    var body = _loadedData
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                children: [
                  ImagePickerTileWidget(
                    title: 'Foto',
                    onChanged: _onFotoChanged,
                  ),
                  TextFormField(
                    controller: _tTitulo,
                    decoration: InputDecoration(
                      labelText: 'Titulo',
                      hintText: 'Ex: Wooly Red',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),
                  ),

                  FutureBuilder<List<CategoriaModelHelper>>(
                      future: _categoryBloc.future(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return ListTile(
                            title: Text(
                                _categoria?.breed ?? 'Selecione a categoria'),
                            subtitle: Text('*Selecione a categoria'),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              push(
                                context,
                                CategorySelectorScreen(
                                  title: 'Categorias',
                                  categorias: snapshot.data ?? [],
                                  especies: null,
                                  onChanged: _setCategory,
                                  routeBack: Routes.CadastrarNinhada,
                                ),
                              );
                            },
                          );
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),],
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );

    return Scaffold(
      bottomNavigationBar: bottomNavBar,
      appBar: appBar,
      body: body,
    );
  }

  // Widget cadastrarPaiMae() {

  // _onMaeChanged(v) {
  //   if (v.runtimeType == Reprodutor) {
  //     v = v as Reprodutor;
  //     setState(() {
  //       _tMae = v;
  //     });
  //   }
  // }

  // _onPaiChanged(v) {
  //   if (v.runtimeType == Reprodutor) {
  //     v = v as Reprodutor;
  //     setState(() {
  //       _tPai = v;
  //     });
  //   }
  // }
  //   return _showDropDown
  //                   ? Column(
  //                       children: [
  //                         StreamBuilder<List<Reprodutor>>(
  //                             stream: _bloc.maesBloc.stream,
  //                             builder: (context, snapshot) {
  //                               if (snapshot.hasData) {
  //                                 var list = snapshot.data;
  //                                 if (list != null) {
  //                                   if (list.isEmpty)
  //                                     return ListTile(
  //                                       title: Text(
  //                                         'Você não tem nenhuma fêmea dessa espécie cadastrada',
  //                                       ),
  //                                       subtitle: Text(
  //                                         'Toque para cadastrar um reprodutor',
  //                                       ),
  //                                       trailing:
  //                                           Icon(Icons.arrow_forward_ios),
  //                                       // onTap: () => pushNamed(context,
  //                                       //     Routes.CadastrarReprodutor),
  //                                     );
  //                                   return Padding(
  //                                     padding: const EdgeInsets.symmetric(
  //                                       horizontal: 8.0,
  //                                     ),
  //                                     child: DropDownButtonWidget<Reprodutor>(
  //                                       value: _tMae,
  //                                       hint: 'Selecione a mae',
  //                                       items: list,
  //                                       onChanged: _onMaeChanged,
  //                                       // hint: 'Teste',
  //                                     ),
  //                                   );
  //                                 }
  //                               }
  //                               return LinearProgressIndicator();
  //                             }),
  //                         StreamBuilder<List<Reprodutor>>(
  //                             stream: _bloc.paisBloc.stream,
  //                             builder: (context, snapshot) {
  //                               if (snapshot.hasData) {
  //                                 var list = snapshot.data;
  //                                 if (list != null) {
  //                                   if (list.isEmpty)
  //                                     return ListTile(
  //                                       title: Text(
  //                                         'Você não tem nenhum macho dessa espécie cadastrado',
  //                                       ),
  //                                       subtitle: Text(
  //                                         'Toque para cadastrar um reprodutor',
  //                                       ),
  //                                       trailing:
  //                                           Icon(Icons.arrow_forward_ios),
  //                                       // onTap: () => pushNamed(
  //                                       //   context,
  //                                       //   Routes.CadastrarReprodutor,
  //                                       // ),
  //                                     );
  //                                   return Padding(
  //                                     padding: const EdgeInsets.symmetric(
  //                                         horizontal: 8.0),
  //                                     child: DropDownButtonWidget<Reprodutor>(
  //                                       value: _tPai,
  //                                       hint: 'Selecione o pai',
  //                                       items: list,
  //                                       onChanged: _onPaiChanged,
  //                                       // hint: 'Teste',
  //                                     ),
  //                                   );
  //                                 }
  //                               }
  //                               return LinearProgressIndicator();
  //                             }),
  //                       ],
  //                     )
  //                   : Container();
  // }
}

class Avancados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}

class FieldWidget extends StatelessWidget {
  final Widget child;
  const FieldWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.grey[500]!.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
