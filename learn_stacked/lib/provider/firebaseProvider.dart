// ignore_for_file: file_names

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  final _storage = GetStorage();

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  Future<bool> googleLogin() async {
    bool _res = false;

    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return _res;
      _user = googleUser;
      log(user.toString() + " ini user");

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      _storage.write('stat', 'google');

      _res = true;
    } catch (e) {
      log(e.toString());
    }
    return _res;
  }

  Future<bool> signInWithEmail(String username, String password) async {
    bool _res = false;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      _storage.write('stat', 'email');
      _res = true;
    } catch (e) {
      log(e.toString());
    }
    return _res;
  }

  Future signUpWithEmail(String username, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> logout() async {
    bool _res = false;
    try {
      final _checkStat = await _storage.read('stat');
      if (_checkStat == 'google') await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
      _res = true;
      _storage.write('stat', null);
    } catch (e) {
      _res = false;
    }
    return _res;
  }

  Future<bool> checkUser() async {
    final _checkStat = await _storage.read('stat');

    final usernya = FirebaseAuth.instance.currentUser;

    log(_checkStat.toString() + " ini stat");
    log(usernya.toString() + " ini usernya");
    // _user = usernya as GoogleSignInAccount?;
    log(user.toString() + " ini user");
    if (usernya == null) return false;
    return true;
  }

  Future checkVerificationEmail() async {
    final emailVerification = FirebaseAuth.instance.currentUser!.emailVerified;

    log(emailVerification.toString() + " ini email verification");

    if (emailVerification == false) {
      sendVerificationEmail();
    }
  }

  Future sendVerificationEmail() async {
    log("sini sending");
    final _usernya = FirebaseAuth.instance.currentUser;
    await _usernya!.sendEmailVerification();
  }

  Future signInWithFacebook() async {
    // Trigger the sign-in flow
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      log(e.toString());
    }
  }
}
