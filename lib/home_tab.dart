import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_page.dart';
import 'profile_tab.dart';
import 'settings_tab.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late String username = '';
  String? userAddress;
  StreamSubscription<Position>? positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  void dispose() {
    // Cancel active operations here
    super.dispose();
  }

  Future<void> fetchUserData() async {
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
        if (userData.containsKey('name') && userData.containsKey('surname') && userData.containsKey('address') && userData.containsKey('birthDate')) {
        }
        if (mounted) {
          setState(() {
            username = userData['name'];

            userAddress = userData['address'];

          });
        } else {
          return;
        }
        } else {
          print('Name field not found');
        }
      }
  }
  Future<void> updateLocationInFirebase(String address) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String documentId = currentUser.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .update({'address': address});
    }
  }


  Future<String> getAddressFromLocation(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String neighborhood = placemark.subLocality ?? '';
        String street = placemark.street ?? '';
        String streetNumber = placemark.thoroughfare ?? '';
        String subAdministrativeArea = placemark.subAdministrativeArea ?? '';
        String postalCode = placemark.postalCode ?? '';
        String country = placemark.country ?? '';

        String address = '$neighborhood Mahallesi, $street Sokak, No: $streetNumber, $subAdministrativeArea, $postalCode, $country';
        return address;
      }
    } catch (e) {
      print('Adres alınamadı: $e');
    }

    return '';
  }

  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    String address = await getAddressFromLocation(position);

    if (address.isNotEmpty) {
      setState(() {
        userAddress = address;
      });
      updateLocationInFirebase(address);
    }
  }

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
                      color: Colors.black38,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      mounted as BuildContext,
                      MaterialPageRoute(builder: (context) => SettingsTab()),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/profile.png'), // Replace with actual image
                  ),
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

          Container(
            margin: EdgeInsets.only(top: 80.0),
            alignment: Alignment.bottomCenter,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
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
                                    Navigator.of(mounted as BuildContext).pop();
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
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 85.0),
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
                    margin: const EdgeInsets.only(top: 26.0, left: 16.0, right: 16.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              mounted as BuildContext,
                              MaterialPageRoute(builder: (context) => ProfileTab()),
                            );
                          },
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage('assets/images/profile.png'), // Replace with actual image
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 16.0), // Add left padding
                                    child: Text(
                                      'Kayıtlı Adresiniz',
                                      style: TextStyle(fontFamily: 'SFPro', fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: getLocation,
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      margin: const EdgeInsets.only(left: 35.0),
                                      child: const Text(
                                        'Anlık Konum Paylaş',
                                        style: TextStyle(
                                          fontFamily: 'SFPro',
                                          fontSize: 14,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0, bottom: 10), // Add left padding
                                child: Text(
                                  userAddress ?? 'Adres bilgisi yükleniyor...',
                                  style: const TextStyle(fontFamily: 'SFPro', fontSize: 14),
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
          ),
    ],),);
  }

}


