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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
    /*case TargetPlatform.iOS:
        return ios;*/
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
    apiKey: 'AIzaSyDCVebc6Ctf0UOJRGflrZ0MjEQBy8tW98Q',
    appId: '1:918980014770:android:ae1605cf5db225c590cfab',
    messagingSenderId: '918980014770',
    projectId: 'demoflutter-9e981',
    storageBucket: 'demoflutter-9e981.appspot.com',
  );

/* static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCP8lr38nQqv0l7QWlhfTaxsUKearLksHk',
    appId: '1:920385720556:ios:9f9a2fc55d4c51181d95c9',
    messagingSenderId: '920385720556',
    projectId: 'digital-interactive-coc',
    storageBucket: 'digital-interactive-coc.appspot.com',
    iosClientId: '920385720556-i5mk80tnigk8sp7qq7c9gmq1io6rv2p2.apps.googleusercontent.com',
    iosBundleId: 'com.coforge.iconf',
  );*/
}