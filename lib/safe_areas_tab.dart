import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SafeAreasTab extends StatefulWidget {

  @override
  _SafeAreasTabState createState() => _SafeAreasTabState();
}

class _SafeAreasTabState extends State<SafeAreasTab> {
  Position? _currentPosition;
  final double _searchRadius = 2000; // 2 km yarıçapı
  late String username = '';
  @override
  void initState() {
    super.initState();
    fetchUserLocation();// Kullanıcının konumunu çekmek için çağrı yapılıyor
    fetchUserName();
  }
  Future<void> fetchUserName() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String documentId = currentUser.uid;
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
  Future<void> fetchUserLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Hata: $e');
    }
  }

  Future<void> _showOnMap(BuildContext context, double lat, double lng) async {
    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Haritalar uygulaması bulunamadı.';
    }
  }

  double calculateDistance(
      double latitude1,
      double longitude1,
      double latitude2,
      double longitude2,
      ) {
    const int earthRadius = 6371; // Dünya yarıçapı (km)

    // Latitude ve longitude farkları
    double latDiff = _toRadians(latitude2 - latitude1);
    double lngDiff = _toRadians(longitude2 - longitude1);

    // Haversine formülü
    double a = pow(sin(latDiff / 2), 2) +
        cos(_toRadians(latitude1)) *
            cos(_toRadians(latitude2)) *
            pow(sin(lngDiff / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double _toRadians(double degree) {
    return degree * (pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      // Kullanıcının konumu henüz alınmadıysa
      return const Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
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
                        'Güvenli bir yer arıyorsan,',
                        style: TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'En yakın ve en güvenli binaları aşağıda senin için sıraladık. En doğru sonucu alabilmek için konumunun doğru olduğuna emin olmalısın. Ayarlardan konumunu kontrol edebilirsin.',
                        style: TextStyle(fontFamily: 'SFPro', fontSize: 15, color: Colors.black38),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 33.0, top: 32.0, right: 32.0, bottom: 10.0),
                  child: const Text(
                    'En Yakın Güvenli Alanlar',
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('safe_areas')
                      .where('is_safe', isEqualTo: true)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Text('Veriler alınırken bir hata oluştu.');
                    }

                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      final safeAreas = snapshot.data!.docs;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: safeAreas.length,
                        itemBuilder: (BuildContext context, int index) {
                          final safeArea = safeAreas[index];
                          final safeAreaData = safeArea.data() as Map<String, dynamic>;

                          // Konum bilgilerini al
                          final double latitude = safeAreaData?['location'].latitude;
                          final double longitude = safeAreaData?['location'].longitude;

                          // Mesafeyi hesapla
                          final double distance = calculateDistance(
                            _currentPosition!.latitude,
                            _currentPosition!.longitude,
                            latitude,
                            longitude,
                          );

                          if (safeAreaData['is_muster'] == true) {
                            // Güvenli alan toplanma alanı ise göster
                            return GestureDetector(
                              onTap: () {
                                _showOnMap(context, latitude, longitude);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 10, left: 32, right: 32, bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                safeAreaData['name'],
                                                style: const TextStyle(
                                                  fontFamily: 'SFPro',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Uzaklık: ${distance.toStringAsFixed(2)} km',
                                                style: const TextStyle(
                                                  fontFamily: 'SFPro',
                                                  fontSize: 14,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward_ios),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            // Güvenli alan güvenli bina ise göster
                            return GestureDetector(
                              onTap: () {
                                _showOnMap(context, latitude, longitude);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 5, left: 32, right: 32, bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.blue,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            safeAreaData['name'],
                                            style: const TextStyle(
                                              fontFamily: 'SFPro',
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Uzaklık: ${distance.toStringAsFixed(2)} km',
                                            style: const TextStyle(
                                              fontFamily: 'SFPro',
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      );
                    }

                    return const Center(child: Text('Güvenli alan bulunamadı.'));
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}