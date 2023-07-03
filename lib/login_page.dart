import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:guvenli_bina_degerlendirme/home_page.dart';
import 'package:guvenli_bina_degerlendirme/sign_up_page.dart';
import 'package:guvenli_bina_degerlendirme/verification_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String _selectedCountryCode = '+90';
  final User? currentUser = FirebaseAuth.instance.currentUser;

  final List<String> _countryCodes = [
    '+90', // Turkey
    '+1', // USA
    '+44', // UK
    '+33', // France
    // Add more country codes as needed
  ];
  @override
  void dispose() {
    // Cancel active operations here
    super.dispose();
  }
  Future<void> _verifyPhoneNumber() async {
    final String phoneNumber = _selectedCountryCode + _phoneNumberController.text;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (currentUser != null) {
      verificationCompleted(PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        print(FirebaseAuth.instance.currentUser!);
        print('login page User uid: ${FirebaseAuth.instance.currentUser!.uid}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }

      verificationFailed(FirebaseAuthException e) {
        print('Verification failed: ${e.message}');
      }

      codeSent(String verificationId, int? resendToken) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationPage(verificationId),
          ),
        );
      }

      try {
        await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } catch (e) {
        print('Phone number verification failed: $e');
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
      return;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign Up Required'),
            content: const Text('You should sign up first.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the popup
                },
                child: const Text('Close'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ),
                  );
                },
                child: const Text('Go to Sign Up'),
              ),
            ],
          );
        },
      );
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
                    'Giriş Yap',
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
                          labelText: 'Telefon Numarası',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _verifyPhoneNumber,
                    child: const Text('Giriş Yap'),
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
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Hesabınız yok mu? Kaydolun',
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
