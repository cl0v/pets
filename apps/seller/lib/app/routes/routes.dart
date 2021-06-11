import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/pages/authentication/login/login_screen.dart';
import 'package:pedigree_seller/app/pages/authentication/splash/splash_screen.dart';
import 'package:pedigree_seller/app/pages/authentication/register/register_screen.dart';
import 'package:pedigree_seller/app/pages/canil/create_canil_screen.dart';
import 'package:pedigree_seller/app/pages/home/canil_profile_screen.dart';
import 'package:pedigree_seller/app/pages/main_screen.dart';
import 'package:pedigree_seller/app/pages/ninhada/ninhada_screen.dart';
import 'package:pedigree_seller/app/pages/ninhada/cadastrar_ninhada_screen.dart';
import 'package:pedigree_seller/app/pages/perfil/perfil_screen.dart';

abstract class Routes {
  static const Splash = '/'; 
  static const Home = '/home';
  static const Login = 'login';
  static const Register = 'login/create';
  static const Perfil = '/user';
  static const Ninhada = '/ninhada';
  static const CadastrarNinhada = '/ninhada/create';
  static const CanilInfo = '/canil';
  static const CadastrarCanil = '/canil/create';
}

final routes = <String, WidgetBuilder>{
  Routes.CanilInfo: (context) => CanilInfoScreen(),
  Routes.CadastrarNinhada: (context) => CadastrarNinhadaScreen(),
  Routes.Login: (context) => LoginScreen(),
  Routes.Register: (context) => RegisterScreen(),
  Routes.Ninhada: (context) => NinhadasScreen(),
  Routes.CadastrarCanil: (context) => CreateCanilScreen(),
  Routes.Home: (context) => MainScreen(),
  Routes.Perfil: (context) => PerfilScreen(),
  Routes.Splash: (context) => SplashScreen(),
};
