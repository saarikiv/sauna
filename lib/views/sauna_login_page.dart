import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sauna/views/sauna_view_args.dart';
import 'package:sauna/routes.dart';
import 'package:sauna/services/login_service.dart';
import 'login_form.dart';

class SaunaLoginPage extends StatefulWidget {
  SaunaLoginPage({Key key, @required this.args}) : super(key: key);
  final SaunaViewArgs args;

  @override
  _SaunaLoginPageState createState() => _SaunaLoginPageState();
}

class _SaunaLoginPageState extends State<SaunaLoginPage> {
  SaunaLoginService _loginService;
  Future<void> _future;
  bool _loginInProgress = false;
  bool _loginFailed = false;

  @override
  void didChangeDependencies() {
    _loginService = Provider.of<SaunaLoginService>(context);
    _future = _loginService.getEmailAndPassword();
    super.didChangeDependencies();
  }

  void _doLogin(String em, String pw) async {
    setState(() {
      _loginInProgress = true;
    });
    await _loginService.setEmailAndPassword(
        em, pw, true); //TODO rememberme checkbox
    bool loginSuccess = await _loginService?.signInWithEmailAndPassword();
    if (loginSuccess) _navigateBack();
    else setState(() {
      _loginFailed = true;
      _loginInProgress = false;
    });
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
        child: FutureBuilder(
          initialData: null,
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            return LogInForm(
              handleSubmit: _doLogin,
              loading: _loginInProgress,
              loginService: _loginService,
              loginFailed: _loginFailed,
            );
          },
        ),
      ),
    );
  }
}
