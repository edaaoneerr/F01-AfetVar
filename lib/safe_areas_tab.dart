import 'package:flutter/material.dart';

class SafeAreasTab extends StatelessWidget {
  final String username = "Elif";

  @override
  Widget build(BuildContext context) {
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
                      'Güvenli bir yer arıyorsan,',
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'En yakın ve en güvenli binaları aşağıda senin için sıraladık. En doğru sonucu alabilmek için  konumunun doğru olduğuna emin olmalısın. Ayarlardan konumunu kontrol edebilirsin. ',
                      style: TextStyle(fontFamily: 'SFPro', fontSize: 15, color: Colors.black38),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: const Text(
                  'Size En Yakın Toplanma Alanı',
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle toplanma alanı item tap
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/muster_point.jpg', // Replace with actual image path
                            width: 50,
                            height: 50,
                          ),
                          Row(
                            children: [

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: const Text(
                                      'Toplanma Alanı',
                                      style: TextStyle(
                                        fontFamily: 'SFPro',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: const Text(
                                      'MORGEN STANLEY PARKI \n ÇEŞME / İZMİR',
                                      style: TextStyle(
                                        fontFamily: 'SFPro',
                                        fontSize: 14,
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const Text(
                                '150m', // Uzaklık bilgisi
                                style: TextStyle(
                                  fontFamily: 'SFPro',
                                  fontSize: 14,
                                  color: Colors.black38,
                                ),
                              ),
                            ],

                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: const Text(
                  'Güvenli Binalar',
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GuvenliBinaItem(
                    binaName: 'Yıldız Ailesi',
                    binaAddress: 'İsmet İnönü Mahallesi, 2032. Sk. No:41, 35930 Çeşme/İzmir',
                    distance: '300m',
                    image: "assets/images/building.jpg",
                  ),
                  GuvenliBinaItem(
                    binaName: 'Güneş Apartmanı',
                    binaAddress: '16 Eylül Mahallesi, 3052. Sk. No:14/B, 35930 Çeşme/İzmir',
                    image: "assets/images/apartment.jpg",
                    distance: '800m',
                  ),
                  GuvenliBinaItem(
                    binaName: 'Akka Hotel',
                    binaAddress: 'Musalla Mahallesi, 1005. Sk. No:4, 35930 Çeşme/İzmir',
                    image: "assets/images/akka_hotel.jpg",
                    distance: '1.2km',
                  ),
                  // Add more Güvenli Bina items as needed
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GuvenliBinaItem extends StatelessWidget {
  final String binaName;
  final String binaAddress;
  final String distance;
  final String image;

  GuvenliBinaItem({required this.binaName, required this.binaAddress, required this.distance, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 16),
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
            Image.asset(
              image, // Replace with actual image path
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    binaName,
                    style: const TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    binaAddress,
                    style: const TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 14,
                      color: Colors.black38,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  distance, // Uzaklık bilgisi
                  style: const TextStyle(
                    fontFamily: 'SFPro',
                    fontSize: 14,
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: TextButton.icon(
                    onPressed: () {
                      _showAlertDialog(context); // Show the alert dialog
                    },
                    icon: const Icon(Icons.warning, size: 13.0),
                    label: const Text('Artık Güvenli Değil', style: TextStyle(fontSize: 9.0),),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Artık güvenli olmadığını teyit etmemiz için bir fotoğraf eklemeniz gerekmektedir.'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Galeriye yönlendirme işlemi yapılabilir
                },
                child: const Text('Galeri'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kapat'),
              ),
            ],
          ),
        );
      },
    );
  }
}
