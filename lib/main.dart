import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pirata_flix/receitas/Favoritas/minhas_receitas_screen.dart';
import 'package:pirata_flix/receitas/screens/refeicao_Screen.dart.dart';
import 'package:pirata_flix/recoveryPassScreen.dart';
import 'package:pirata_flix/registerScreen.dart';
import 'receitas/screens/tela_mapa.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'homeLoginScreen.dart';
import 'homeScreen.dart';
import 'loginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: MaterialColor(
        0xFFF57F17, // Cor amarela
        <int, Color>{
          50: Color(0xFFFFFDE7),
          100: Color(0xFFFFF9C4),
          200: Color(0xFFFFF59D),
          300: Color(0xFFFFF176),
          400: Color(0xFFFFEE58),
          500: Color(0xFFFFEB3B),
          600: Color(0xFFFDD835),
          700: Color(0xFFFBC02D),
          800: Color(0xFFF9A825),
          900: Color(0xFFF57F17),
        },
      ),
    ),
    initialRoute: '/home',
    routes: {
      "/home": (_) => HomeScreen(),
      "/register": (_) => RegisterScreen(),
      "/login": (_) => LoginScreen(),
      "/homeLogin": (_) => HomeLoginScreen(),
      '/recoveryPass': (_) => RecoveryPasswordScreen(),

      '/receitas': (_) => RecipesScreen(),
      '/minhas_receitas': (_) => MinhasReceitasScreen(receitasFavoritas: []),


      '/telamapa': (_) => TelaMapa(),
    },
  ));
}
