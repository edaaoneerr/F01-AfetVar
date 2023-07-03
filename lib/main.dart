import 'package:flutter/material.dart';
import 'package:guvenli_bina_degerlendirme/home_page.dart';
import 'package:guvenli_bina_degerlendirme/login_page.dart';
import 'package:guvenli_bina_degerlendirme/sign_up_page.dart';

import 'home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Güvenli Bina ve Tehlike Değerlendirme',
      theme: ThemeData(
        fontFamily: 'SFPro',
        primarySwatch: Colors.red, // Tema rengi olarak kırmızı seçildi
      ),
      home: SignUpPage(),
    );
  }

}
