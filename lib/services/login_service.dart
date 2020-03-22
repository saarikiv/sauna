import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../views/sauna_basic_args.dart';

class SaunaLoginService {
  final SaunaBasicArgs args;

  SaunaLoginService({@required this.args});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool _loginComplete = false;

  Future<bool> signInWithEmailAndPassword() async {
    user = (await _auth.signInWithEmailAndPassword(
      email: 'tuomo.saarikivi@outlook.com',
      password: 'aki3003',
    ))
        .user;
    if (user != null) {
      args.analytics.logLogin(loginMethod: 'email_password');
      args.analytics.setUserId(user.hashCode.toString());
      _loginComplete = true;
    } else {
      _loginComplete = false;
    }
    return _loginComplete;
  }
}
