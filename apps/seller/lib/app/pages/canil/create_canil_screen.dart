import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:seller/app/components/custom_button_widget.dart';
import 'package:seller/app/components/form_error_text.dart';
import 'package:seller/app/components/text_input_field_widget.dart';
import 'package:seller/app/pages/authentication/user_model.dart';
import 'package:seller/app/pages/canil/store_bloc.dart';
import 'package:seller/app/routes/routes.dart';
import 'package:seller/app/utils/app_bar.dart';
import 'package:seller/app/utils/screen_size.dart';

class CreateCanilScreen extends StatefulWidget {
  @override
  _CreateCanilScreenState createState() => _CreateCanilScreenState();
}

class _CreateCanilScreenState extends State<CreateCanilScreen> {
  final _tNome = TextEditingController();
  final _tContato = TextEditingController();
  final _tInstagram = TextEditingController();

  late final StoreBloc _bloc;
  bool _dataLoaded = false;

  bool _showError = false;

  @override
  void initState() {
    super.initState();
    UserModel.get().then((u) {
      if (u != null) _bloc = StoreBloc(u.id!);
      setState(() {
        _dataLoaded = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.createBtnBloc.dispose();
  }

  _onCreatePressed() async {
    if (!(_validateNome() == null &&
        _validateContato() == null &&
        _validateInstagram() == null)) {
      setState(() {
        _showError = true;
      });
      return;
    }
    setState(() {
      _showError = false;
    });

    String nome = _tNome.text;
    String contato = _tContato.text;
    String instagram = _tInstagram.text;

    final canil = Store(title: nome, phone: contato, instagram: instagram);

    var c = await _bloc.create(canil);

    if (c != null)
      pushNamed(context, Routes.Home, replace: true);
    else
      alert(context, 'Error na criação de conta!');
  }

  String? _validateNome() {
    //TODO: Implement
    var text = _tNome.text;
    if (text.isEmpty) {
      return "Digite o nome";
    }
    return null;
  }

  String? _validateContato() {
    //TODO: Implement
    var text = _tContato.text;
    if (text.isEmpty) {
      return "Digite o telefone";
    }
    return null;
  }

  String? _validateInstagram() {
    //TODO: Implement
    var text = _tInstagram.text;
    if (text.isEmpty) {
      return "Digite o instagram";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = getSize(context);

    var appBar = customAppBar(
      'Cadastrar canil',
      automaticallyImplyLeading: false,
    );

    var bottomButton = _dataLoaded
        ? BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.1,
                0,
                size.width * 0.1,
                8,
              ),
              child: StreamBuilder(
                stream: _bloc.createBtnBloc.stream,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return CustomButtonWidget(
                    'Register',
                    onPressed: _onCreatePressed,
                    showProgress: snapshot.data ?? false,
                  );
                },
              ),
            ),
          )
        : Container();

    var body = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView(
        children: [
          TextInputFieldWidget(
            icon: Icons.store,
            hint: 'Titulo',
            inputAction: TextInputAction.next,
            controller: _tNome,
          ),
          _validateNome() != null && _showError
              ? FormErrorText(_validateNome()!)
              : Container(),
          TextInputFieldWidget(
            icon: Icons.phone,
            hint: 'Contato',
            inputAction: TextInputAction.next,
            inputType: TextInputType.phone,
            controller: _tContato,
          ),
          _validateContato() != null && _showError
              ? FormErrorText(_validateContato()!)
              : Container(),
          TextInputFieldWidget(
            icon: Icons.document_scanner,
            hint: 'Instagram',
            inputAction: TextInputAction.next,
            inputType: TextInputType.number,
            controller: _tInstagram,
          ),
          _validateInstagram() != null && _showError
              ? FormErrorText(_validateInstagram()!)
              : Container(),
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: bottomButton,
      body: body,
    );
  }
}
