import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:sauna/views/sauna_view_args.dart';
import 'package:sauna/views/sauna_home_page.dart';
import 'package:sauna/routes.dart';
import 'package:sauna/services/login_service.dart';
import 'package:sauna/services/sauna_service_args.dart';
import 'package:sauna/services/slot_service.dart';

class SaunaApp extends StatefulWidget {
  final SaunaViewArgs vArgs;
  final SaunaServiceArgs sArgs;

  SaunaApp({@required this.vArgs, @required this.sArgs});

  @override
  State<StatefulWidget> createState() {

    final loginService = SaunaLoginService(args: sArgs);
    final slotService = SlotService(args: sArgs);

    return _SaunaAppState(
      loginService: loginService,
      slotService: slotService,
    );

  }
}

class _SaunaAppState extends State<SaunaApp> {

  final SaunaLoginService loginService;
  final SlotService slotService;

  _SaunaAppState({
    @required this.loginService,
    @required this.slotService,
  });

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
        Provider<SlotService>(
          create: (_) => slotService,
        ),
      ],
      child: MaterialApp(
        title: 'Hakolahdentie 2, Sauna',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SaunaHomePage(
          args: widget.vArgs,
        ),
        onGenerateRoute: Routes.sailor.generator(),
        navigatorKey: Routes.sailor.navigatorKey,
        navigatorObservers: [SailorLoggingObserver()],
      ),
    );
  }
}
