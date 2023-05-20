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
    apiKey: 'AIzaSyA0mVhcZURAqH6kBMYjuotWhtYLBv85oxE',
    appId: '1:924567143903:web:7379441aeb6aa43001706a',
    messagingSenderId: '924567143903',
    projectId: 'bharatride-d69af',
    authDomain: 'bharatride-d69af.firebaseapp.com',
    storageBucket: 'bharatride-d69af.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYJQ61mAF-JHYgUZprk9i8yrYq3aQZL30',
    appId: '1:924567143903:android:364e5f89d2edaad001706a',
    messagingSenderId: '924567143903',
    projectId: 'bharatride-d69af',
    storageBucket: 'bharatride-d69af.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDeooV_wPD9ZerWBgppHnvihH9ysJM-IJ4',
    appId: '1:924567143903:ios:089e4d93135b7fe601706a',
    messagingSenderId: '924567143903',
    projectId: 'bharatride-d69af',
    storageBucket: 'bharatride-d69af.appspot.com',
    iosClientId:
        '924567143903-t2pfs05s87e5dp6o9fdfb6pk4qk5qcpo.apps.googleusercontent.com',
    iosBundleId: 'com.example.Bharatride',
  );
}
