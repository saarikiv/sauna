import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sauna/services/sauna_service_args.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sauna_service_args.dart';

const EMAIL_KEY = 'em';
const PWD_KEY = 'pw';
const REMEMBER_ME_KEY = 'rm';

class SaunaLoginService {
  final SaunaServiceArgs args;

  SaunaLoginService({@required this.args});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  bool _loginComplete = false;

  bool loginComplete() => _loginComplete;

  String _email;
  String _password;
  bool _rememberMe = false;
  SharedPreferences _instance;

  Future<void> getEmailAndPassword() async {
    final instance = await _getInstance();
    _rememberMe = instance.getBool(REMEMBER_ME_KEY);
    _rememberMe = (_rememberMe == null)
        ? false
        : _rememberMe; //if nothing stored -> false.
    if (_rememberMe) {
      _email = instance.getString(EMAIL_KEY);
      _password = instance.getString(PWD_KEY);
    } else {
      _email = '';
      _password = '';
    }
  }

  String get email => _email;

  String get pwd => _password;

  Future<void> setEmailAndPassword(String em, String pw, bool persist) async {
    _email = em;
    _password = pw;
    _rememberMe = persist;
    final instance = await _getInstance();
    instance.setBool(REMEMBER_ME_KEY, persist);
    if (persist) {
      instance.setString(PWD_KEY, _password);
      instance.setString(EMAIL_KEY, _email);
    } else {
      instance.setString(PWD_KEY, '');
      instance.setString(EMAIL_KEY, '');
    }
  }

  Future<bool> signInWithEmailAndPassword() async {
    try {
      user = (await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      ))
          .user;
      if (user != null) {
        args.analytics.logLogin(loginMethod: 'email_password');
        args.analytics.setUserId(user.hashCode.toString());
        _loginComplete = true;
      } else {
        _loginComplete = false;
      }
    } catch (error) {
      _loginComplete = false;
      print("Login failed: " + error.toString());
    }
    return _loginComplete;
  }

  Future<SharedPreferences> _getInstance() async {
    if (_instance == null) {
      _instance = await SharedPreferences.getInstance();
    }
    return _instance;
  }
}
