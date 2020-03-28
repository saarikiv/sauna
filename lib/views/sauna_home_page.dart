import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'sauna_view_args.dart';
import 'package:sauna/routes.dart';
import 'package:sauna/services/login_service.dart';

class SaunaHomePage extends StatefulWidget {
  SaunaHomePage({Key key, @required this.args}) : super(key: key);
  final SaunaViewArgs args;

  @override
  _SaunaHomePageState createState() => _SaunaHomePageState();
}

class _SaunaHomePageState extends State<SaunaHomePage> {
  SaunaLoginService loginService;

  @override
  void didChangeDependencies() {
    loginService = Provider.of<SaunaLoginService>(context);
    super.didChangeDependencies();
  }

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
      navigationType: NavigationType.push,
      args: widget.args,
    );
  }

  void _shopPressed() {
    widget.args.analytics.logEvent(
      name: 'shopPressed',
      parameters: {
        'app': 'sauna',
      },
    );
    Routes.sailor.navigate(
      Routes.SHOP_ROUTE_NAME,
      transitions: [
        SailorTransition.fade_in,
      ],
      transitionDuration: Duration(milliseconds: 500),
      transitionCurve: Curves.decelerate,
      navigationType: NavigationType.push,
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
              color: Colors.black,
              disabledColor: Colors.grey,
              child: Text(
                'login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: loginService.loginComplete()? _loginPressed : _loginPressed,
            ),
            FlatButton(
              color: Colors.black,
              disabledColor: Colors.grey,
              child: Text(
                'slots',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: loginService.loginComplete() ? _slotsPressed : null,
            ),
            FlatButton(
              color: Colors.black,
              disabledColor: Colors.grey,
              child: Text(
                'shop',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: loginService.loginComplete() ? _shopPressed : null,
            ),
          ],
        ),
      ),
    );
  }
}
