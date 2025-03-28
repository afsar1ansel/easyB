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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDeMXFL7Rpc8QYT631siSCqN7xTlWai4-s',
    appId: '1:957185824155:android:b37473c500993354e73d3e',
    messagingSenderId: '957185824155',
    projectId: 'easybizz-mobile',
    storageBucket: 'easybizz-mobile.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRKGCqrbYPFV8WCmfkd3Civ_h7myhLftg',
    appId: '1:957185824155:ios:e1dd916f6ddfaea6e73d3e',
    messagingSenderId: '957185824155',
    projectId: 'easybizz-mobile',
    storageBucket: 'easybizz-mobile.firebasestorage.app',
    androidClientId: '957185824155-n8dhl1oq5q5nhoqlc4jqk4ms70mbka8k.apps.googleusercontent.com',
    iosClientId: '957185824155-tv8q36mifua5viagnu9a7th7ecfq786f.apps.googleusercontent.com',
    iosBundleId: 'com.example.easybizMobile',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBWPtuT5ug2ShUHSdOt81Qs0Po9Rf1n2Os',
    appId: '1:957185824155:web:523caa9efb6ea67ce73d3e',
    messagingSenderId: '957185824155',
    projectId: 'easybizz-mobile',
    authDomain: 'easybizz-mobile.firebaseapp.com',
    storageBucket: 'easybizz-mobile.firebasestorage.app',
    measurementId: 'G-EKPHSCHRFJ',
  );

}