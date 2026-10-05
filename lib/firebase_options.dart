// File generated or configured for Firebase options.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
          'you can reconfigure this by running the FlutterFire CLI.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD-YourWebApiKeyPlaceholder',
    appId: '1:472598060862:web:10a20b30c40d50',
    messagingSenderId: '472598060862',
    projectId: 'resume-a3e92',
    authDomain: 'resume-a3e92.firebaseapp.com',
    storageBucket: 'resume-a3e92.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-YourAndroidApiKeyPlaceholder',
    appId: '1:472598060862:android:20a30b40c50d60',
    messagingSenderId: '472598060862',
    projectId: 'resume-a3e92',
    storageBucket: 'resume-a3e92.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-YourIosApiKeyPlaceholder',
    appId: '1:472598060862:ios:30a40b50c60d70',
    messagingSenderId: '472598060862',
    projectId: 'resume-a3e92',
    storageBucket: 'resume-a3e92.firebasestorage.app',
    iosBundleId: 'com.example.resume',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-YourMacosApiKeyPlaceholder',
    appId: '1:472598060862:ios:30a40b50c60d70',
    messagingSenderId: '472598060862',
    projectId: 'resume-a3e92',
    storageBucket: 'resume-a3e92.firebasestorage.app',
    iosBundleId: 'com.example.resume',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD-YourWindowsApiKeyPlaceholder',
    appId: '1:472598060862:web:10a20b30c40d50',
    messagingSenderId: '472598060862',
    projectId: 'resume-a3e92',
    authDomain: 'resume-a3e92.firebaseapp.com',
    storageBucket: 'resume-a3e92.firebasestorage.app',
  );
}
