import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'sauna_basic_args.dart';
import '../routes.dart';

class SaunaHomePage extends StatefulWidget {
  SaunaHomePage({Key key, @required this.args}) : super(key: key);
  final SaunaBasicArgs args;

  @override
  _SaunaHomePageState createState() => _SaunaHomePageState();
}

class _SaunaHomePageState extends State<SaunaHomePage> {
  void _loginPressed() {
    widget.args.analytics.logEvent(
      name: 'loginPressed',
      parameters: {
        'app': 'sauna',
      },
    );
    Routes.sailor.navigate(
      Routes.LOGIN_ROUTE_NAME,
      transitions: [
        SailorTransition.fade_in,
      ],
      transitionDuration: Duration(milliseconds: 500),
      transitionCurve: Curves.decelerate,
      navigationType: NavigationType.push,
      args: widget.args,
    );
  }

  void _slotsPressed() {
    widget.args.analytics.logEvent(
      name: 'slotsPressed',
      parameters: {
        'app': 'sauna',
      },
    );
    Routes.sailor.navigate(
      Routes.SLOTS_ROUTE_NAME,
      transitions: [
        SailorTransition.fade_in,
      ],
      transitionDuration: Duration(milliseconds: 500),
      transitionCurve: Curves.decelerate,
      navigationType: NavigationType.pushReplace,
      args: widget.args,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              child: Text(
                'login',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: _loginPressed,
            ),
            FlatButton(
              child: Text(
                'slots',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onPressed: _slotsPressed,
            ),
          ],
        ),
      ),
    );
  }
}
