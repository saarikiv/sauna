import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:sauna/slot.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
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
  runApp(MyApp(firebaseApp: app));
}

class MyApp extends StatelessWidget {
  final FirebaseApp firebaseApp;

  MyApp({this.firebaseApp});

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hakolahdentie 2, Sauna',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Hakolahdentie 2 sauna',
        analytics: analytics,
        observer: observer,
        firebaseApp: firebaseApp,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(
      {Key key, this.title, this.analytics, this.observer, this.firebaseApp})
      : super(key: key);

  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final FirebaseApp firebaseApp;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  void _signInWithEmailAndPassword() async {
    user = (await _auth.signInWithEmailAndPassword(
      email: 'tuomo.saarikivi@outlook.com',
      password: 'aki3003',
    ))
        .user;
    if (user != null) {
      widget.analytics.logLogin(loginMethod: 'email_password');
      widget.analytics.setUserId(user.hashCode.toString());
      setState(() {
        _counter = 1000;
      });
    } else {
      _counter = -1000;
    }
  }

  Future<Widget> _readFromDatabase(BuildContext context) async {
    FirebaseDatabase database = FirebaseDatabase(app: widget.firebaseApp, );
    DataSnapshot snapshot = await FirebaseDatabase.instance.reference().child('slots').once();
    return fromDynamic(snapshot.value, context);
  }

  Widget fromDynamic(dynamic data, BuildContext context) {
    Map<dynamic, dynamic> values = data;
    values.forEach((key, value) {
      return Slot.fromDynamic(value).present(context);
    });
    return Text(data.toString());
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _sendCounterIncrease(_counter);
    });
  }

  Future<void> _sendCounterIncrease(int newValue) async {
    await widget.analytics.logEvent(
      name: 'counter_increase',
      parameters: <String, dynamic>{
        'target': 'counter_value',
        'operation': 'increase',
        'value': newValue,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            FlatButton(
              child: Text(
                'login',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: _signInWithEmailAndPassword,
            ),
            FlatButton(
              child: Text(
                'read from DB',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: () => _readFromDatabase(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
