import 'package:commons/models/product.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:seller/app/components/category_screen.dart';
import 'package:seller/app/pages/canil/store_bloc.dart';
import 'package:seller/app/pages/ninhada/ninhada_bloc.dart';
import 'package:seller/app/routes/routes.dart';
import 'package:seller/app/utils/scaffold_common_components.dart';

import 'package:commons/commons.dart';

import '../../../constants.dart';

class _CategoryBloc {
  Future<List<CategoriaModelHelper>> get future async =>
      CategoryRepository().get();
}

class CreateProductScreen extends StatefulWidget {
  final Product? product;

  const CreateProductScreen({Key? key, this.product}) : super(key: key);
  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  late final ProductBloc _bloc = ProductBloc();
  final _CategoryBloc _categoryBloc = _CategoryBloc();
  Product? get product => widget.product;

  late final _tTitulo;
  Categoria? _categoria;

  @override
  void initState() {
    super.initState();
    _tTitulo = TextEditingController(text: product?.title);
    _categoria = product?.category;
  }

  @override
  dispose() {
    super.dispose();
    _bloc.createBtnBloc.dispose();
  }

  _setCategory(String categoria, String especie) {
    setState(() {
      //BUG: Quando troca a categoria pela segunda vez, nao atualiza as opções
      _categoria = Categoria(
        category: categoria,
        breed: especie,
      );
    });
  }

  bool _continue = true;

  _onCreatePressed() async {
    //TODO: Do jeito que ta fica impossivel trocar a foto
    if (_tTitulo.text == '' || _categoria == null)
      return alert(context, 'Por favor preencha todos os campos');
    late String storeId;
    if (product != null) {
      await _bloc.update(product!.copyWith(
        title: _tTitulo.text,
        category: _categoria!,
      ));

      storeId = product!.storeId;
    } else {
      storeId = (await StoreBloc().fetch())!.id;
      final ninhada = Product(
        title: _tTitulo.text,
        storeId: storeId,
        category: _categoria!,
      );
      if (foto != null) {
        await _bloc.create(
          foto!,
          ninhada,
        );
      } else
        return alert(
            context, 'Não foi possivel cadastrar, pois voce nao enviou imagem');
    }
    return pop(context);
  }

  PlatformFile? foto;
  _onFotoChanged(PlatformFile foto) {
    this.foto = foto;
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavBar = StreamBuilder(
      stream: _bloc.createBtnBloc.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return ScaffoldCommonComponents.customBottomAppBar(
          'Continuar',
          _continue ? _onCreatePressed : null,
          context,
          snapshot.data ?? false,
        );
      },
    );
    final appBar = AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      actions: [
        product != null
            ? IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.grey[800],
                ),
                onPressed: () async {
                  _bloc.delete(product!);
                  pop(context);
                },
              )
            : Container(),
      ],
      title: Text(
        'Novo',
        style: kTitleTextStyle,
      ),
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey[800],
          ),
          onPressed: () => pop(context),
        );
      }),
    );

    var body = Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            product == null
                ? ImagePickerTileWidget(
                    title: 'Foto',
                    onChanged: _onFotoChanged,
                  )
                : Text('Ainda não é possivel trocar a foto na edição'),
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
                future: _categoryBloc.future,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return ListTile(
                      title: Text(_categoria?.breed ?? 'Selecione a categoria'),
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
                }),
          ],
        ),
      ),
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
