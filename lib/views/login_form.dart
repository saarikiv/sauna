import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sauna/services/login_service.dart';

// ignore: must_be_immutable
class LogInForm extends StatefulWidget {
  final Function(String, String) handleSubmit;
  final bool loading;
  final bool loginFailed;
  SaunaLoginService loginService;

  LogInForm(
      {@required this.handleSubmit,
      @required this.loading,
      @required this.loginService,
      @required this.loginFailed});

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_SignInFormState');

  final _emailController = TextEditingController(
    text: '',
  );
  final _passwordController = TextEditingController(
    text: '',
  );

  @override
  void initState() {
    _emailController.text = widget.loginService.email;
    _passwordController.text = widget.loginService.pwd;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Sähköposti:',
            ),
            validator: _emailValidator,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Salasana:',
            ),
            obscureText: true,
            validator: _passwordValidator,
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: _buttonChild(),
              onPressed: _handlePress(),
            ),
          ),
          Visibility(
            visible: widget.loginFailed,
            child: Text(
              'Kirjautuminen epäonnistui. Tarkista sähköposti tai salasana.',
              maxLines: 3,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonChild() {
    if (widget.loading) {
      return Stack(
          alignment: Alignment.center,
          children: <Widget>[
        Text(
          'Kirjaudu',
          maxLines: 1,
        ),
        CircularProgressIndicator(),
      ]);
    }

    return Text(
      'Kirjaudu',
      maxLines: 1,
    );
  }

  String _emailValidator(String email) {
    final valid = EmailValidator.validate(email);
    if (!valid) {
      return 'Tarkista sähköposti!';
    }
    return null;
  }

  String _passwordValidator(String password) {
    String pattern = r'^(?=.*\d).{6,100}$';
    RegExp regExp = new RegExp(pattern);
    final valid = regExp.hasMatch(password);
    if (!valid) {
      return 'Salasana pitää olla vähintään 6 merkkiä.';
    }
    return null;
  }

  void Function() _handlePress() {
    if (widget.loading) {
      return null;
    }

    return () {
      final valid = _formKey.currentState.validate();
      if (valid) {
        final email = _emailController.value.text;
        final password = _passwordController.value.text;
        widget.handleSubmit(email, password);
      }
    };
  }
}
