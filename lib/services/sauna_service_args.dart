import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';


class SaunaServiceArgs extends BaseArguments {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final FirebaseApp firebaseApp;

  SaunaServiceArgs({
    @required this.analytics,
    @required this.observer,
    @required this.firebaseApp,
  });

}