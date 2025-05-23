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
    apiKey: 'AIzaSyBZfwGWmkfuDyIpfwSaoC47nEMqKiUz46w',
    appId: '1:623412706069:web:777b7c68f8bd2c13e2871c',
    messagingSenderId: '623412706069',
    projectId: 'iot-lab-2e4a1',
    authDomain: 'iot-lab-2e4a1.firebaseapp.com',
    databaseURL: 'https://iot-lab-2e4a1-default-rtdb.firebaseio.com',
    storageBucket: 'iot-lab-2e4a1.firebasestorage.app',
    measurementId: 'G-W19R5BBXKB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCd3T29nAzKB10BKTkN1UUpCyQiVipCFzg',
    appId: '1:623412706069:android:b7f252c18d5848dae2871c',
    messagingSenderId: '623412706069',
    projectId: 'iot-lab-2e4a1',
    databaseURL: 'https://iot-lab-2e4a1-default-rtdb.firebaseio.com',
    storageBucket: 'iot-lab-2e4a1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYbD30JK_XwMi6ME2QaFMi-Li5re_y68k',
    appId: '1:623412706069:ios:186c96bbd2ddc03ee2871c',
    messagingSenderId: '623412706069',
    projectId: 'iot-lab-2e4a1',
    databaseURL: 'https://iot-lab-2e4a1-default-rtdb.firebaseio.com',
    storageBucket: 'iot-lab-2e4a1.firebasestorage.app',
    iosBundleId: 'com.smart.smartHome',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCYbD30JK_XwMi6ME2QaFMi-Li5re_y68k',
    appId: '1:623412706069:ios:186c96bbd2ddc03ee2871c',
    messagingSenderId: '623412706069',
    projectId: 'iot-lab-2e4a1',
    databaseURL: 'https://iot-lab-2e4a1-default-rtdb.firebaseio.com',
    storageBucket: 'iot-lab-2e4a1.firebasestorage.app',
    iosBundleId: 'com.smart.smartHome',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBZfwGWmkfuDyIpfwSaoC47nEMqKiUz46w',
    appId: '1:623412706069:web:0c60f878607880fee2871c',
    messagingSenderId: '623412706069',
    projectId: 'iot-lab-2e4a1',
    authDomain: 'iot-lab-2e4a1.firebaseapp.com',
    databaseURL: 'https://iot-lab-2e4a1-default-rtdb.firebaseio.com',
    storageBucket: 'iot-lab-2e4a1.firebasestorage.app',
    measurementId: 'G-XH28MS3CQD',
  );
}
