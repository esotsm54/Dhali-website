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
    apiKey: 'AIzaSyBro8QN3zyJwyo92lYUMPwsyRVPLLGOTcs',
    appId: '1:1042340549063:web:3dc69cffe6d3c0746189e2',
    messagingSenderId: '1042340549063',
    projectId: 'dhali-prod',
    authDomain: 'dhali-prod.firebaseapp.com',
    storageBucket: 'dhali-prod.appspot.com',
    measurementId: 'G-6TPZFK7NQ6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCfRfa00z6-D3nrh30ae1AExwq8zAD4Ewc',
    appId: '1:1042340549063:android:d5545ff0cf77939d6189e2',
    messagingSenderId: '1042340549063',
    projectId: 'dhali-prod',
    storageBucket: 'dhali-prod.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtmY0Mi0ZGcNNix8aUkGXNpsSOmd7kYY0',
    appId: '1:1042340549063:ios:a81f48bfedea09d26189e2',
    messagingSenderId: '1042340549063',
    projectId: 'dhali-prod',
    storageBucket: 'dhali-prod.appspot.com',
    iosClientId: '1042340549063-0o8laprh36ak67eoonug93c33c5ot4fb.apps.googleusercontent.com',
    iosBundleId: 'com.example.testWebsite',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtmY0Mi0ZGcNNix8aUkGXNpsSOmd7kYY0',
    appId: '1:1042340549063:ios:a81f48bfedea09d26189e2',
    messagingSenderId: '1042340549063',
    projectId: 'dhali-prod',
    storageBucket: 'dhali-prod.appspot.com',
    iosClientId: '1042340549063-0o8laprh36ak67eoonug93c33c5ot4fb.apps.googleusercontent.com',
    iosBundleId: 'com.example.testWebsite',
  );
}
