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
    apiKey: 'AIzaSyC0io2eH_7oE45wLxzc7uDV3XHQcgHcZrA',
    appId: '1:642212907515:web:f9c97c2395861f9c26e35e',
    messagingSenderId: '642212907515',
    projectId: 'deepface-a1dfd',
    authDomain: 'deepface-a1dfd.firebaseapp.com',
    storageBucket: 'deepface-a1dfd.appspot.com',
    measurementId: 'G-CY3WJT13FN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7KhTVu50gSzbH7D3hgo8i5YikZfsXLZY',
    appId: '1:642212907515:android:823d6c633c41134e26e35e',
    messagingSenderId: '642212907515',
    projectId: 'deepface-a1dfd',
    storageBucket: 'deepface-a1dfd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGhEIZx8EvlUetIpPqe4x387jTy5Gv0ow',
    appId: '1:642212907515:ios:25921cd016cabaa426e35e',
    messagingSenderId: '642212907515',
    projectId: 'deepface-a1dfd',
    storageBucket: 'deepface-a1dfd.appspot.com',
    iosBundleId: 'com.example.client',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBGhEIZx8EvlUetIpPqe4x387jTy5Gv0ow',
    appId: '1:642212907515:ios:ff850e78a6fba19026e35e',
    messagingSenderId: '642212907515',
    projectId: 'deepface-a1dfd',
    storageBucket: 'deepface-a1dfd.appspot.com',
    iosBundleId: 'com.example.client.RunnerTests',
  );
}
