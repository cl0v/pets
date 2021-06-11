import 'package:commons/commons.dart';
import 'package:pedigree_seller/app/pages/authentication/register/register_bloc.dart';
import 'package:pedigree_seller/app/components/text_input_field_widget.dart';
import 'package:pedigree_seller/app/utils/scaffold_common_components.dart';
import 'package:pedigree_seller/app/pages/authentication/user_model.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/components/form_error_text.dart';
import 'package:pedigree_seller/app/routes/routes.dart';
import 'package:pedigree_seller/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _bloc = RegisterBloc();

  final _tEmail = TextEditingController();
  final _tNome = TextEditingController();
  final _tContato = TextEditingController();
  final _tSenha = TextEditingController();
  final _tConfSenha = TextEditingController();

  bool _showError = false;

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  _onRegisterPressed() async {
    final validation = !(_validateEmail() == null &&
        _validateNome() == null &&
        _validateContato() == null &&
        _validateSenha() == null);
    if (validation) {
      setState(() {
        _showError = true;
      });
      return;
    }
    setState(() {
      _showError = false;
    });

    String email = _tEmail.text;
    String nome = _tNome.text;
    String contato = _tContato.text;
    String senha = _tSenha.text;

    UserModel u = UserModel(nome: nome, email: email, contato: contato);

    var response = await _bloc.register(email, senha, u);

    response
        ? pushNamed(context, Routes.Home, replace: true)
        : alert(context, 'Error na criação de conta!');
  }

  _onBackToLoginPressed() {
    pop(context);
  }

  String? _validateEmail() {
    var text = _tEmail.text;
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
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


  String? _validateSenha() {
    var text = _tSenha.text;
    var conf = _tConfSenha.text;
    if (text.isEmpty || conf.isEmpty) {
      return "Digite a senha";
    }
    if (text != conf) {
      return "Precisam ser iguais";
    }
    if (text.length < 3) {
      return "A senha precisa ter pelo menos 3 números";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var backBtn = Center(
      child: RichText(
        text: TextSpan(
          style: kBodyTextStyle,
          children: [
            TextSpan(
              text: 'Já tem uma conta?',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
                text: ' Entrar',
                style: TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = _onBackToLoginPressed),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: ScaffoldCommonComponents.customAppBarWithoutIcons('Cadastrar'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            TextInputFieldWidget(
              icon: Icons.email,
              hint: 'Email',
              inputAction: TextInputAction.next,
              inputType: TextInputType.emailAddress,
              controller: _tEmail,
            ),
            if (_showError) FormErrorText(_validateEmail()),

            TextInputFieldWidget(
              icon: Icons.person,
              hint: 'Nome',
              inputAction: TextInputAction.next,
              controller: _tNome,
            ),
            if (_showError) FormErrorText(_validateNome()),

            TextInputFieldWidget(
              icon: Icons.phone,
              hint: 'Telefone',
              inputAction: TextInputAction.next,
              inputType: TextInputType.phone,
              controller: _tContato,
            ),
            _validateContato() != null && _showError
                ? FormErrorText(_validateContato())
                : Container(),
            TextInputFieldWidget(
              icon: Icons.lock,
              hint: 'Senha',
              inputAction: TextInputAction.next,
              isObscure: true,
              controller: _tSenha,
            ),
            _validateSenha() != null && _showError
                ? FormErrorText(_validateSenha())
                : Container(),
            TextInputFieldWidget(
              icon: Icons.lock,
              hint: 'Confirmar senha',
              inputAction: TextInputAction.done,
              isObscure: true,
              controller: _tConfSenha,
            ),
            _validateSenha() != null && _showError
                ? FormErrorText(_validateSenha()!)
                : Container(),
            SizedBox(
              height: 12,
            ),
            //
            _BottomButton(stream: _bloc.stream, onPressed: _onRegisterPressed),
            SizedBox(
              height: 10,
            ),
            backBtn,
          ],
        ),
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  const _BottomButton({Key? key, required this.stream, required this.onPressed})
      : super(key: key);

  final Stream stream;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BottomAppBar(
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
                stream: stream,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return CustomButtonWidget(
                    'Register',
                    onPressed: onPressed,
                    showProgress: snapshot.data ?? false,
                  );
                })));
  }
}
