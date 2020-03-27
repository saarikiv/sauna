import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:sauna/views/sauna_view_args.dart';
import 'package:sauna/views/sauna_home_page.dart';
import 'package:sauna/routes.dart';
import 'package:sauna/services/login_service.dart';
import 'package:sauna/services/sauna_service_args.dart';
import 'package:sauna/services/slot_service.dart';
import 'package:sauna/services/shop_item_service.dart';
import 'package:sauna/services/varausserver_service.dart';

class SaunaApp extends StatefulWidget {
  final SaunaViewArgs vArgs;
  final SaunaServiceArgs sArgs;

  SaunaApp({@required this.vArgs, @required this.sArgs});

  @override
  State<StatefulWidget> createState() {

    final loginService = SaunaLoginService(args: sArgs);
    final slotService = SlotService(args: sArgs);
    final shopItemService = ShopItemService(args: sArgs);

    return _SaunaAppState(
      loginService: loginService,
      slotService: slotService,
      shopItemService: shopItemService,
    );

  }
}

class _SaunaAppState extends State<SaunaApp> {

  final SaunaLoginService loginService;
  final SlotService slotService;
  final ShopItemService shopItemService;
  final varausServerService = VarausServerService();

  _SaunaAppState({
    @required this.loginService,
    @required this.slotService,
    @required this.shopItemService,
  });

  @override void dispose() {
    varausServerService.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Routes.createRoutes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<VarausServerService>(
          create: (_) => varausServerService,
        ),
        Provider<SaunaLoginService>(
          create: (_) => loginService,
        ),
        Provider<SlotService>(
          create: (_) => slotService,
        ),
        Provider<ShopItemService>(
          create: (_) => shopItemService,
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
