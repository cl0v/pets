import 'package:commons/commons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seller/app/components/custom_button_widget.dart';
import 'package:seller/app/components/form_error_text.dart';
import 'package:seller/app/components/text_input_field_widget.dart';
import 'package:seller/app/pages/authentication/login/login_bloc.dart';
import 'package:seller/app/routes/routes.dart';
import 'package:seller/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _bloc = LoginBloc();
  //TODO: Remover text:
  final _tEmail = TextEditingController(text: 'marcelofv12@hotmail.com');
  final _tSenha = TextEditingController(text: 'mkillfv12');
  bool _showError = false;

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  _onLoginPressed() async {
    //TODO: Conferir a validação primeiro

    if (!(_validateEmail() == null && _validateSenha() == null)) {
      setState(() {
        _showError = true;
      });
      return;
    }
    setState(() {
      _showError = false;
    });
    String email = _tEmail.text;
    String senha = _tSenha.text;

    var response = await _bloc.login(email, senha);

    if (response != null) {
      
      pushNamed(context, Routes.Home, replace: true);
    } else
      alert(context, 'Error no login');
  }

  _onRegisterPressed() {
    pushNamed(context, Routes.Register);
  }

  String? _validateEmail() {
    var text = _tEmail.text;
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String? _validateSenha() {
    var text = _tSenha.text;
    if (text.isEmpty) {
      return "Digite a senha";
    }
    if (text.length < 3) {
      return "A senha precisa ter pelo menos 3 números";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Center(
                child: Text(
                  'Pedigree',
                  style: TextStyle(
                    color: Colors.red.withOpacity(.8),
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  TextInputFieldWidget(
                    hint: 'Email',
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    controller: _tEmail,
                  ),
                  _validateEmail() != null && _showError
                      ? FormErrorText(_validateEmail()!)
                      : Container(),
                  TextInputFieldWidget(
                    hint: 'Senha',
                    icon: Icons.lock,
                    isObscure: true,
                    inputAction: TextInputAction.done,
                    controller: _tSenha,
                  ),
                  _validateSenha() != null && _showError
                      ? FormErrorText(_validateSenha()!)
                      : Container(),
                  SizedBox(
                    height: 25,
                  ),
                  StreamBuilder(
                    stream: _bloc.stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return CustomButtonWidget(
                        'Entrar',
                        onPressed: _onLoginPressed,
                        showProgress: snapshot.data ?? false,
                      );
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            Center(
              child: RichText(
                  text: TextSpan(
                text: 'Criar conta',
                style: kBodyTextStyle.copyWith(
                    fontSize: 16, decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()..onTap = _onRegisterPressed,
              )),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
