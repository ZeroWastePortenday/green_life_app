import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:green_life_app/utils/logger.dart';

class Google {
  static Future<bool> login() async {
    try {
      final googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );
      final account = await googleSignIn.signIn();

      if (account == null) {
        throw Exception('not logged in');
      }

      final authentication = await account.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      // Firebase Sign in
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredential.user != null;
    } catch (error) {
      Log.e(error);
      return false;
    }
  }

  static void logout(BuildContext context, void Function() callback) {
    GoogleSignIn(
      scopes: [
        'email',
      ],
    ).signOut().then((value) {
      firebaseLogout(context, callback);
    });
  }
}


void firebaseLogout(BuildContext context, void Function() callback) {
  FirebaseAuth.instance.signOut().then((value) {
    callback();
  });
}