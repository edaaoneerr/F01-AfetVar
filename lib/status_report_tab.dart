import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'earthquake_page.dart';

class StatusReportTab extends StatefulWidget {
  @override
  State<StatusReportTab> createState() => _StatusReportTabState();
}

class _StatusReportTabState extends State<StatusReportTab> {
  late String username = '';

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  @override
  void dispose() {
    // Cancel active operations here
    super.dispose();
  }

  Future<void> fetchUserName() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String documentId = currentUser.uid;


      print('home tab User uid: ${FirebaseAuth.instance.currentUser!.uid}');
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
        if (userData.containsKey('name')) {
        }
        if (mounted) {
          setState(() {
            username = userData['name'];

          });
        } else {
          return;
        }
      } else {
        print('Name field not found');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Tekrar hoşgeldin, $username',
                          style: const TextStyle(
                            fontFamily: 'SFPro',
                            fontSize: 17,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/profile.png'),
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
                        'Acil durum bildir',
                        style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Aciliyetini ayrıntılarıyla bildirmek için bu sayfayı kullanabilirsin. Senden ricamız, gerçekten doğru olduğundan emin olduğun güvenilir bildirilerde bulunman. Unutma, her durumda seni veya etrafındakileri iyileştirmek için uğraşacağız.',
                        style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 15,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView(
                      padding: const EdgeInsets.all(16.0),
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EarthquakePage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(
                                    Icons.apartment_outlined,
                                    size: 48.0,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Text(
                                  'Deprem',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 24.0,
                                ),
                                SizedBox(width: 16.0),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => YanginPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(
                                    Icons.fire_extinguisher,
                                    size: 48.0,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Text(
                                  'Yangın',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 24.0,
                                ),
                                SizedBox(width: 16.0),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelPage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(
                                    Icons.waves,
                                    size: 48.0,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Text(
                                  'Sel',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 24.0,
                                ),
                                SizedBox(width: 16.0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class YanginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yangın'),
      ),
      body: const Center(
        child: Text('Yangın Page'),
      ),
    );
  }
}

class SelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sel'),
      ),
      body: const Center(
        child: Text('Sel Page'),
      ),
    );
  }
}
