import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sauna/views/sauna_view_args.dart';
import 'package:sauna/routes.dart';
import 'package:sauna/services/login_service.dart';

class SaunaLoginPage extends StatefulWidget {
  SaunaLoginPage({Key key, @required this.args}) : super(key: key);
  final SaunaViewArgs args;

  @override
  _SaunaLoginPageState createState() => _SaunaLoginPageState();
}

class _SaunaLoginPageState extends State<SaunaLoginPage> {
  SaunaLoginService _loginService;

  @override
  void didChangeDependencies() {
    _loginService = Provider.of<SaunaLoginService>(context);
    super.didChangeDependencies();
  }

  void _doLogin() async {
    bool loginSuccess = await _loginService?.signInWithEmailAndPassword();
    if (loginSuccess) _navigateBack();
  }

  void _navigateBack() {
    Routes.sailor.pop();
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
            Text(
              'Kirjaudu sähköpostilla ja salasanalla',
            ),
            FlatButton(
              color: Colors.black,
              child: Text(
                'login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: _doLogin,
            ),
          ],
        ),
      ),
    );
  }
}
