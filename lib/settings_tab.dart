import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late String username = '';
  late String userAddress = '';
  late String userSurname = '';
  late String userBloodType = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String documentId = currentUser.uid;

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
        userSnapshot.data() as Map<String, dynamic>;
        if (userData.containsKey('name')) {
          setState(() {
            username = userData['name'];
          });
        } else {
          username = '';
        }
        if (userData.containsKey('address')) {
          setState(() {
            userAddress = userData['address'];
          });
        } else {
          userAddress = '';
        }
        if (userData.containsKey('surname')) {
          setState(() {
            userSurname = userData['surname'];
          });
        } else {
          userSurname = '';
        }
        if (userData.containsKey('bloodType')) {
          setState(() {
            userBloodType = userData['bloodType'];
          });
        } else {
          userBloodType = '';
        }
      } else {
        print('User data not found');
      }
    }
  }

  String _selectedImage = 'assets/images/profile.png'; // Replace with your own image path
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _bloodTypeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

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
                        'Merhaba, $username',
                        style: const TextStyle(
                          fontFamily: 'SFPro',
                          fontSize: 17,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(_selectedImage),
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
                      'Bilgilerinin doğruluğunu kontrol et',
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Bu sayfadaki bilgileri sana ulaşabilmemiz için belirli aralıklarla kontrol etmeni öneriyoruz. Afetler bazen habersiz gelebilir, konumun veya kişisel bilgilerin değiştiğinde buradan güncellersen acil durum sırasında hızlıca sana ulaşmamız kolaylaşır. Merak etme, bilgilerin doğruysa şarjın bitse bile en son konumundan sana ulaşacağız.',
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontSize: 15,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: _showImagePickerDialog,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(_selectedImage),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'İsmin',
                        ),
                        style: const TextStyle(fontSize: 15.0),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: _surnameController,
                        decoration: const InputDecoration(
                          labelText: 'Soyismin',
                        ),
                        style: const TextStyle(fontSize: 15.0),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Açık Adresin',
                        ),
                        style: const TextStyle(fontSize: 15.0),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        controller: _bloodTypeController,
                        decoration: const InputDecoration(
                          labelText: 'Kan Grubun',
                        ),
                        style: const TextStyle(fontSize: 15.0),
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          updateUserData();
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                        child: const Text('Kaydet'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Profile Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () {
                  setState(() {
                    _selectedImage = 'assets/images/profile_gallery.png';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  setState(() {
                    _selectedImage = 'assets/images/profile_camera.png';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void updateUserData() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String documentId = currentUser.uid;

      Map<String, dynamic> updatedData = {};

      if (_nameController.text.isNotEmpty && _nameController.text != username) {
        updatedData['name'] = _nameController.text;
      }
      if (_addressController.text.isNotEmpty && _addressController.text != userAddress) {
        updatedData['address'] = _addressController.text;
      }
      if (_surnameController.text.isNotEmpty && _surnameController.text != userSurname) {
        updatedData['surname'] = _surnameController.text;
      }
      if (_bloodTypeController.text.isNotEmpty && _bloodTypeController.text != userBloodType) {
        updatedData['bloodType'] = _bloodTypeController.text;
      }

      FirebaseFirestore.instance
          .collection('users')
          .doc(documentId)
          .update(updatedData)
          .then((value) {
        _showSuccessDialog(context);
        fetchUserData();
      }).catchError((error) {
        print('Failed to update user data: $error');
      });
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Başarılı'),
          content: const Text('Bilgilerin başarıyla güncellendi.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
}
