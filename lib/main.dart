import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'sauna_app.dart';
import 'views/sauna_basic_args.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseApp firebaseApp = await FirebaseApp.configure(
    name: 'hakolhdentie-2',
    options: Platform.isIOS
        ? const FirebaseOptions(
            googleAppID: '1:883401530976:ios:1f33c56f2d109aec7bad05',
            gcmSenderID: '883401530976',
            databaseURL: 'https://hakolahdentie-2.firebaseio.com',
          )
        : const FirebaseOptions(
            googleAppID: '1:883401530976:android:2aec5b0f822223c9',
            apiKey: 'AIzaSyDRIDY5SB_HU_gXenn358QQx0mbvbIOXGQ',
            databaseURL: 'https://hakolahdentie-2.firebaseio.com',
          ),
  );
  final FirebaseAnalytics analytics = FirebaseAnalytics();
  final FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);



  final args = SaunaBasicArgs(
    title: 'Hakolahdentie 2 sauna',
    analytics: analytics,
    observer: observer,
    firebaseApp: firebaseApp,
  );
  runApp(SaunaApp(args: args));
}

