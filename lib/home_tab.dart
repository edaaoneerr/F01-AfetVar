import 'package:flutter/material.dart';
import 'profile_tab.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  String? username = 'Elif';
  String? selectedDisaster;
  double sliderValue = 0.0;
  List<String> selectedStatuses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.only(top: 60.0, right: 20.0, left: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Hoşgeldin, $username',
                    style: const TextStyle(
                        fontFamily: 'SFPro',
                        fontSize: 17,
                        color: Colors.black38
                    ),
                  ),
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/profile.png'), // Replace with actual image
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 33.0, left: 33.0, top: 15.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tehlikede misin?',
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Acil yardım ekiplerinin hızlıca sana ulaşması için butona tıkla. Konumunun doğruluğundan emin olursan, sana daha hızlı ulaşabileceğimizi unutma.',
                  style: TextStyle(fontFamily: 'SFPro', fontSize: 15, color: Colors.black38),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Acil Durum Bildirimi'),
                              content: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Acil durum merkezlerine afet bildirimi gönderildi.',
                                    style: TextStyle(fontFamily: 'SFPro', fontSize: 16),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Kısa süre içerisinde, konumunuza acil durum merkezleri gönderilecektir.',
                                    style: TextStyle(fontFamily: 'SFPro', fontSize: 16),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Kapat',
                                    style: TextStyle(fontFamily: 'SFPro', fontSize: 16),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(16.0),
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: const Center(
                          child: Text(
                            'AFET VAR!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'SFPro',
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/profile.png'), // Replace with actual image
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.0), // Add left padding
                              child: Text(
                                'Mevcut Adresiniz',
                                style: TextStyle(fontFamily: 'SFPro', fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.only(left: 16.0), // Add left padding
                              child: Text(
                                '16 Eylül Mahallesi, Hürriyet Cd. No:40, 35930, Çeşme/İzmir',
                                style: TextStyle(fontFamily: 'SFPro', fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
