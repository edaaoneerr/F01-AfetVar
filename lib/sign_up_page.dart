import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guvenli_bina_degerlendirme/login_page.dart';
import 'verification_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  String _selectedCountryCode = '+90';

  final List<String> _countryCodes = [
    '+90', // Turkey
    '+1', // USA
    '+44', // UK
    '+33', // France
    // Add more country codes as needed
  ];

  Future<void> _verifyPhoneNumber() async {
    final String phoneNumber = _selectedCountryCode + _phoneNumberController.text;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _saveUserDetails();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);

      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Call _saveUserDetails here

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationPage(verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
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
      print('Sign up page User uid: ${FirebaseAuth.instance.currentUser!.uid}');

    } catch (e) {
      print('Error saving user details: $e');
    }
  }

  void _showCountryCodeMenu() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Country Code'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _countryCodes.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_countryCodes[index]),
                  onTap: () {
                    setState(() {
                      _selectedCountryCode = _countryCodes[index];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
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
                    'Kayıt Ol',
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _showCountryCodeMenu,
                      child: Text(
                        _selectedCountryCode,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Telefon Numarası'
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: _verifyPhoneNumber,
                    child: const Text('Devam Et'),
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
