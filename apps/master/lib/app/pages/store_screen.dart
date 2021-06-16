
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:master/app/pages/product_screen.dart';

class StoreBloc {
  final _r = StoreFirebase();

  get stream => _r.readAll();

  create(Store s) => _r.create(s);

  delete(String id) => _r.delete(id);
}

class StoreListScreen extends StatefulWidget {
  const StoreListScreen({Key? key}) : super(key: key);

  @override
  _StoreListScreenState createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  final _bloc = StoreBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(context, CreateStoreScreen());
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<Store>>(
        stream: _bloc.stream,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final l = snapshot.data!;
            return ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(l[i].title),
                  subtitle: Text(l[i].phone),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () {
                          push(
                              context,
                              CreateStoreScreen(
                                store: l[i],
                              ));
                        },
                        icon: Icon(Icons.edit),
                      )
                    ],
                  ),
                  onTap: () {
                    push(
                      context,
                      ProductListScreen(
                        store: l[i],
                      ),
                    );
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
    );
  }
}

class CreateStoreScreen extends StatefulWidget {
  final Store? store;
  const CreateStoreScreen({
    Key? key,
    this.store,
  }) : super(key: key);

  @override
  _CreateStoreScreenState createState() => _CreateStoreScreenState();
}

class _CreateStoreScreenState extends State<CreateStoreScreen> {
  late final _tTitle;
  late final _tPhone;
  late final _tInstagram;
  final _bloc = StoreBloc();

  @override
  void initState() {
    super.initState();
    _tTitle = TextEditingController(text: widget.store?.title);
    _tPhone = TextEditingController(text: widget.store?.phone);
    _tInstagram = TextEditingController(text: widget.store?.instagram);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.store?.title ?? 'Create'),
        actions: [
          widget.store != null
              ? IconButton(
                  onPressed: () {
                    _bloc.delete(widget.store!.id);
                    pop(context);
                  },
                  icon: Icon(Icons.delete),
                )
              : Container()
        ],
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Title'),
            controller: _tTitle,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Phone'),
            controller: _tPhone,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Insta'),
            controller: _tInstagram,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Store s = Store(
            title: _tTitle.text,
            instagram: _tInstagram.text,
            phone: _tPhone.text,
          );
          _bloc.create(s);
          pop(context);
        },
        child: Icon(
          Icons.check,
        ),
      ),
    );
  }
}
