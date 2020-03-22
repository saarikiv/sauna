import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:sauna/views/sauna_basic_args.dart';
import 'package:sauna/views/sauna_home_page.dart';
import 'package:sauna/routes.dart';
import 'package:sauna/services/login_service.dart';

class SaunaApp extends StatefulWidget {

  final SaunaBasicArgs args;
  SaunaApp({@required this.args});

  @override
  State<StatefulWidget> createState() {
    final loginService = SaunaLoginService(args: args);
    return _SaunaAppState(loginService: loginService);
  }

}

class _SaunaAppState extends State<SaunaApp> {

  final SaunaLoginService loginService;
  _SaunaAppState({@required this.loginService});

  @override
  void initState() {
    Routes.createRoutes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SaunaLoginService>(
          create: (_) => loginService,
        ),
      ],
      child: MaterialApp(
        title: 'Hakolahdentie 2, Sauna',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SaunaHomePage(
          args: widget.args,
        ),
        onGenerateRoute: Routes.sailor.generator(),
        navigatorKey: Routes.sailor.navigatorKey,
        navigatorObservers: [SailorLoggingObserver()],
      ),
    );
  }
}
