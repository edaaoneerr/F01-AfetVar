import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guvenli_bina_degerlendirme/home_page.dart';
import 'package:guvenli_bina_degerlendirme/login_page.dart';
import 'verification_page.dart';

class SignUpContinuePage extends StatefulWidget {
  @override
  _SignUpContinuePageState createState() => _SignUpContinuePageState();
}

class _SignUpContinuePageState extends State<SignUpContinuePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  Future<void> _saveUserDetails() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      final String name = _nameController.text;
      final String surname = _surnameController.text;
      final String address = _addressController.text;
      final String birthDate = _birthDateController.text;

      await _firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
        'name': name,
        'surname': surname,
        'address': address,
        'birthDate': birthDate,
      });
      print('User details saved to Firestore');
      print(FirebaseAuth.instance.currentUser!);
      print('Sign up CONTINUE page User uid: ${FirebaseAuth.instance.currentUser!.uid}');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );

    } catch (e) {
      print('Error saving user details: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 90.0),
                  child: Text(
                    'Kişisel Bilgilerin',
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Ad',
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _surnameController,
                    decoration: const InputDecoration(
                      labelText: 'Soyad',
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Yaşadığınız Şehir',
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _birthDateController,
                    decoration: const InputDecoration(
                      labelText: 'Doğum Tarihi',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: _saveUserDetails,
                    child: const Text('Kaydol'),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Zaten hesabınız var mı? Giriş yapın',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
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
