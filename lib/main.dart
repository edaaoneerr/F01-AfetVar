import 'package:flutter/material.dart';
import 'package:guvenli_bina_degerlendirme/home_page.dart';

import 'home_page.dart';

void main() {

  runApp(MyApp());
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
      home: HomePage(),
    );
  }
}
