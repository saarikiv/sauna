import 'package:flutter/material.dart';
import 'package:sailor/sailor.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';


class SaunaViewArgs extends BaseArguments {
  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final FirebaseApp firebaseApp;

  SaunaViewArgs({
    @required this.title,
    @required this.analytics,
    @required this.observer,
    @required this.firebaseApp,
  });

}