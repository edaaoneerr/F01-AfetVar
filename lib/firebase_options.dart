// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBAwRX3E2NLBxekvFCRRPbuem3WS3aQbuI',
    appId: '1:681613733368:web:b135f687937113e10cfa0d',
    messagingSenderId: '681613733368',
    projectId: 'afetvar-47b46',
    authDomain: 'afetvar-47b46.firebaseapp.com',
    storageBucket: 'afetvar-47b46.appspot.com',
    measurementId: 'G-1JS658R5E7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9drb4-p7QNIq0IP4A2gRQoNJD8-vV2Sk',
    appId: '1:681613733368:android:49bdc3f0c10d57f80cfa0d',
    messagingSenderId: '681613733368',
    projectId: 'afetvar-47b46',
    storageBucket: 'afetvar-47b46.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSd0awXhVBdlo3e_ny0UYSCNsmpM_XrDU',
    appId: '1:681613733368:ios:e3afb8ae6ed6ccf50cfa0d',
    messagingSenderId: '681613733368',
    projectId: 'afetvar-47b46',
    storageBucket: 'afetvar-47b46.appspot.com',
    iosClientId: '681613733368-4iuvmj519d4vmihvnamv7m89i5njkmas.apps.googleusercontent.com',
    iosBundleId: 'com.edaaoneerr.guvenliBinaDegerlendirme',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDSd0awXhVBdlo3e_ny0UYSCNsmpM_XrDU',
    appId: '1:681613733368:ios:a6a31ea62352c41a0cfa0d',
    messagingSenderId: '681613733368',
    projectId: 'afetvar-47b46',
    storageBucket: 'afetvar-47b46.appspot.com',
    iosClientId: '681613733368-8pblt7qs3u9estvblj55nuadf5ik361d.apps.googleusercontent.com',
    iosBundleId: 'com.edaaoneerr.guvenliBinaDegerlendirme.RunnerTests',
  );
}
