import 'package:flutter/material.dart';
import 'home_tab.dart';
import 'profile_tab.dart';
import 'safe_areas_tab.dart';
import 'settings_tab.dart';
import 'status_report_tab.dart';
import 'earthquake_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeTab(),
    StatusReportTab(),
    SafeAreasTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red, // Kırmızı tema
      ),
      home: Scaffold(
        body: _tabs[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.red, // Tab bar rengi
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Anasayfa',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.report),
                label: 'Durum Bildir',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.security),
                label: 'Güvenli Alanlar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Ayarlar',
              ),
            ],
            backgroundColor: Colors.red, // Tab bar rengi
            selectedItemColor: Colors.red, // Seçili sekme ikon ve metin rengi
            unselectedItemColor: Colors.grey, // Seçili olmayan sekme ikon ve metin rengi
          ),
        ),
      ),
    );
  }
}
