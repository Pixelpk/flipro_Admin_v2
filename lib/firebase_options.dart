import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfUxkhCklD8roDbt0hMxgMu3KGaieA3VA',
    appId: '1:936207297131:android:7a32abce5e9fcdaa741f2e',
    messagingSenderId: '936207297131',
    projectId: 'flipro-admin',
    storageBucket: 'flipro-admin.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDnZStALyqRqrqF7XdiT6-sPzTIHGKbB7I',
    appId: '1:936207297131:ios:d9a8d032b54cf927741f2e',
    messagingSenderId: '936207297131',
    projectId: 'flipro-admin',
    storageBucket: 'flipro-admin.appspot.com',
    // androidClientId: '865306367197-fgfc33ecn84me1ibt4tlfecr37lfa3fr.apps.googleusercontent.com',
    // iosClientId: '865306367197-59kpvjqrp32cvlvpoav5fr9j4sqertcu.apps.googleusercontent.com',
    iosBundleId: 'com.flipro.renovateadminapp',
  );
}
