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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBrRFMfMt8mhR0z4arHC9S98dGkhAoAJ9s',
    appId: '1:676698379868:web:56eec81f20af49636ef899',
    messagingSenderId: '676698379868',
    projectId: 'getifyjobsrecuriter',
    authDomain: 'getifyjobsrecuriter.firebaseapp.com',
    storageBucket: 'getifyjobsrecuriter.appspot.com',
    measurementId: 'G-B1PDBC0RBP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBDniucIynGLMD5MdSk6U6VDcbz3ft-zyk',
    appId: '1:676698379868:android:677ca1527ded07936ef899',
    messagingSenderId: '676698379868',
    projectId: 'getifyjobsrecuriter',
    storageBucket: 'getifyjobsrecuriter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwh28zBOQbfzhj7WL1ehq9NO6oUPp6Roo',
    appId: '1:676698379868:ios:c35feef006c92b546ef899',
    messagingSenderId: '676698379868',
    projectId: 'getifyjobsrecuriter',
    storageBucket: 'getifyjobsrecuriter.appspot.com',
    iosBundleId: 'com.getifyjobs.recuriter',
  );
}
