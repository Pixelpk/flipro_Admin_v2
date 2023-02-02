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
    apiKey: 'AIzaSyBbgU093yOUmPj-UsHTH4AJlwt8FXPo_zQ',
    appId: '1:865306367197:android:bdb947485e5eadcbf17734',
    messagingSenderId: '865306367197',
    projectId: 'flipro-c6b6d',
    storageBucket: 'flipro-c6b6d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRkNxdGUBNUPqAiCjG970oGcUM1XAPMPs',
    appId: '1:865306367197:ios:c7ec873ccbf9a4c4f17734',
    messagingSenderId: '865306367197',
    projectId: 'flipro-c6b6d',
    storageBucket: 'flipro-c6b6d.appspot.com',
    androidClientId: '865306367197-fgfc33ecn84me1ibt4tlfecr37lfa3fr.apps.googleusercontent.com',
    iosClientId: '865306367197-59kpvjqrp32cvlvpoav5fr9j4sqertcu.apps.googleusercontent.com',
    iosBundleId: 'com.flipro.renovateadminapp',
  );
}
