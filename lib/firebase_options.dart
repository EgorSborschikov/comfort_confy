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
    apiKey: 'AIzaSyDGz3b7uI4o8wmzA-rMoio4N2YXUgY1JTw',
    appId: '1:489037754348:web:967308a18ebd649d589ac9',
    messagingSenderId: '489037754348',
    projectId: 'comfortconfy-60adb',
    authDomain: 'comfortconfy-60adb.firebaseapp.com',
    storageBucket: 'comfortconfy-60adb.firebasestorage.app',
    measurementId: 'G-2F2GWW9GZG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBwobWU50DavktTsmwaGESH-XB-P_fy6L8',
    appId: '1:489037754348:android:80a82c8d386a55fa589ac9',
    messagingSenderId: '489037754348',
    projectId: 'comfortconfy-60adb',
    storageBucket: 'comfortconfy-60adb.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAlaMd4OHUNYo-Hxo7l6dx8AYVwbejisfg',
    appId: '1:489037754348:ios:9c9530fdcfe84679589ac9',
    messagingSenderId: '489037754348',
    projectId: 'comfortconfy-60adb',
    storageBucket: 'comfortconfy-60adb.firebasestorage.app',
    iosBundleId: 'com.mobilsapp.comfortConfy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAlaMd4OHUNYo-Hxo7l6dx8AYVwbejisfg',
    appId: '1:489037754348:ios:9c9530fdcfe84679589ac9',
    messagingSenderId: '489037754348',
    projectId: 'comfortconfy-60adb',
    storageBucket: 'comfortconfy-60adb.firebasestorage.app',
    iosBundleId: 'com.mobilsapp.comfortConfy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDGz3b7uI4o8wmzA-rMoio4N2YXUgY1JTw',
    appId: '1:489037754348:web:460a4ec4976b7dfd589ac9',
    messagingSenderId: '489037754348',
    projectId: 'comfortconfy-60adb',
    authDomain: 'comfortconfy-60adb.firebaseapp.com',
    storageBucket: 'comfortconfy-60adb.firebasestorage.app',
    measurementId: 'G-SGHFFJTJSF',
  );
}