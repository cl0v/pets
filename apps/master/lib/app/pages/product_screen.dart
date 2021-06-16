import 'package:commons/commons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:master/app/widgets/category_screen.dart';

class ProductBloc {
  final String storeId;
  final _rep = ProductFirebase();

  ProductBloc(this.storeId);

  get stream => _rep.readFromStore(storeId);

  create(PlatformFile img, Product p) => _rep.create(img, p);
}



class ProductListScreen extends StatefulWidget {
  final Store store;
  const ProductListScreen({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductBloc get _bloc => ProductBloc(widget.store.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.store.title),
      ),
      body: StreamBuilder<List<Product>>(
        stream: _bloc.stream,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final l = snapshot.data!;
            return ListView.builder(
              itemCount: l.length,
              itemBuilder: (c, i) {
                final p = l[i];
                return ListTile(
                  title: Text(p.title),
                  subtitle: Text(p.approved.toString()),
                  onTap: () {
                    push(
                        context,
                        CreateProductScreen(
                          storeId: widget.store.id,
                          product: p,
                        ));
                  },
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(
              context,
              PetCategorySectionWidget(
                storeId: widget.store.id,
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CreateProductScreen extends StatefulWidget {
  final String storeId;
  final Product? product;
   //TODO: Por enquanto nao edita
  //Para editar preciso usar o set no lugar do create
  final Categoria? category;
  const CreateProductScreen({
    Key? key,
    required this.storeId,
    this.product,
    this.category,
  }) : super(key: key);

  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  late final _tTitle;
  ProductBloc get _bloc => ProductBloc(widget.storeId);

  @override
  void initState() {
    super.initState();
    _tTitle = TextEditingController(text: widget.product?.title);
  }

  PlatformFile? img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create'),
      ),
      body: Column(
        children: [
          ImagePickerTileWidget(
            onChanged: (i) {
              print('trocando de img agr : $i');
              img = i;
            },
            title: 'Foto',
          ),
          TextField(
            controller: _tTitle,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Product p = Product(
            imgUrl: '',
            storeId: widget.storeId,
            title: _tTitle.text,
            category: widget.category!,
          );
          _bloc.create(img!, p);
          pop(context);
        },
        child: Icon(
          Icons.check,
        ),
      ),
    );
  }
}