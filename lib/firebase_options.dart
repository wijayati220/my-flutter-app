// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAZQo9pQKSK-eSxQxDWdc5kYHJOkRaHLCQ',
    appId: '1:1077533525971:web:440d61725852d129e71126',
    messagingSenderId: '1077533525971',
    projectId: 'my-flutter-app-abc99',
    authDomain: 'my-flutter-app-abc99.firebaseapp.com',
    storageBucket: 'my-flutter-app-abc99.appspot.com',
    measurementId: 'G-E2L9VLDTXV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBw5M2GA9cjaX-Zs9TZ4QpvtulywEuP31o',
    appId: '1:1077533525971:android:35e63b6acd194ec8e71126',
    messagingSenderId: '1077533525971',
    projectId: 'my-flutter-app-abc99',
    storageBucket: 'my-flutter-app-abc99.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzpcXLfLuxBhmHalBGdt_mb_8MRoq0LJk',
    appId: '1:1077533525971:ios:6374dd6113cc6ad7e71126',
    messagingSenderId: '1077533525971',
    projectId: 'my-flutter-app-abc99',
    storageBucket: 'my-flutter-app-abc99.appspot.com',
    iosBundleId: 'com.example.myFlutterApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDzpcXLfLuxBhmHalBGdt_mb_8MRoq0LJk',
    appId: '1:1077533525971:ios:6374dd6113cc6ad7e71126',
    messagingSenderId: '1077533525971',
    projectId: 'my-flutter-app-abc99',
    storageBucket: 'my-flutter-app-abc99.appspot.com',
    iosBundleId: 'com.example.myFlutterApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAZQo9pQKSK-eSxQxDWdc5kYHJOkRaHLCQ',
    appId: '1:1077533525971:web:aa8fa6b44b9b84b5e71126',
    messagingSenderId: '1077533525971',
    projectId: 'my-flutter-app-abc99',
    authDomain: 'my-flutter-app-abc99.firebaseapp.com',
    storageBucket: 'my-flutter-app-abc99.appspot.com',
    measurementId: 'G-MPD4CL1NXK',
  );
}
