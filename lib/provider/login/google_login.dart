import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:green_life_app/utils/logger.dart';

class Google {
  static Future<bool> login() async {
    try {
      final account = await getGoogleAccountHasEmailScope();
      return await getLoginResultIfAccountNotNull(account);
    } catch (error) {
      Log.e(error);
      return false;
    }
  }

  static Future<GoogleSignInAccount?> getGoogleAccountHasEmailScope() async {
    final googleSignIn = GoogleSignIn(scopes: ['email']);
    final account = await googleSignIn.signIn();
    return account;
  }

  static Future<bool> getLoginResultIfAccountNotNull(
    GoogleSignInAccount? account,
  ) async {
    var loginResult = false;
    if (account != null) {
      loginResult = await getLoginResult(account);
    }
    return loginResult;
  }

  static Future<bool> getLoginResult(GoogleSignInAccount account) async {
    final authentication = await getAuthentication(account);
    final googleCredential = getGoogleCredential(authentication);
    final firebaseUserCredential = await getFirebaseUserCredentialByGoogleCredential(googleCredential);
    return isFirebaseUserNotNull(firebaseUserCredential);
  }

  static bool isFirebaseUserNotNull(UserCredential firebaseUserCredential) =>
      firebaseUserCredential.user != null;

  static OAuthCredential getGoogleCredential(
    GoogleSignInAuthentication authentication,
  ) =>
      GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

  static Future<GoogleSignInAuthentication> getAuthentication(
    GoogleSignInAccount account,
  ) async =>
      account.authentication;

  static Future<UserCredential> getFirebaseUserCredentialByGoogleCredential(
    OAuthCredential credential,
  ) async =>
      FirebaseAuth.instance.signInWithCredential(credential);

  static void logout(BuildContext context, void Function() callback) =>
      GoogleSignIn(scopes: ['email']).signOut().then((value) {
        firebaseLogout(context, callback);
      });
}

void firebaseLogout(BuildContext context, void Function() callback) {
  FirebaseAuth.instance.signOut().then((_) {
    callback();
  });
}
