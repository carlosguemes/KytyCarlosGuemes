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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBQ-qhBUB_q70Nr4_LPAoKiWqdQY6W1ijg',
    appId: '1:317613099827:web:ec4c04aecf34e13eda8c46',
    messagingSenderId: '317613099827',
    projectId: 'kyty-carlos-guemes',
    authDomain: 'kyty-carlos-guemes.firebaseapp.com',
    storageBucket: 'kyty-carlos-guemes.appspot.com',
    measurementId: 'G-TTGBHHM1DH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTsZHd4rFkcXWZg263vfy5CrKE5pUD-DQ',
    appId: '1:317613099827:android:4dbff32499fe2c21da8c46',
    messagingSenderId: '317613099827',
    projectId: 'kyty-carlos-guemes',
    storageBucket: 'kyty-carlos-guemes.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2mHr0vrkBl81bXOMP9oPKCwL87kDiBZg',
    appId: '1:317613099827:ios:1c9cbed9089a54c8da8c46',
    messagingSenderId: '317613099827',
    projectId: 'kyty-carlos-guemes',
    storageBucket: 'kyty-carlos-guemes.appspot.com',
    iosBundleId: 'org.carlos.kyty',
  );
}
