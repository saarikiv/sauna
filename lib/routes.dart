import 'package:flutter/animation.dart';
import 'package:sailor/sailor.dart';
import 'package:sauna/views/sauna_home_page.dart';
import 'package:sauna/views/sauna_login_page.dart';
import 'package:sauna/views/sauna_slot_page.dart';
import 'package:sauna/views/sauna_shop_page.dart';


class Routes {
  static final sailor = Sailor();

  static const HOME_ROUTE_NAME = '/';
  static const LOGIN_ROUTE_NAME = '/login';
  static const SLOTS_ROUTE_NAME = '/slots';
  static const SHOP_ROUTE_NAME = '/shop';

  static void createRoutes() {
    sailor.addRoutes([
      SailorRoute(
          name: HOME_ROUTE_NAME,
          builder: (context, args, params) {
            return SaunaHomePage(args: args,);
          }),
      SailorRoute(
          name: LOGIN_ROUTE_NAME,
          defaultTransitions: [
            SailorTransition.slide_from_bottom,
            SailorTransition.zoom_in,
          ],
          defaultTransitionCurve: Curves.decelerate,
          defaultTransitionDuration: Duration(milliseconds: 300),
          builder: (context, args, params) {
            return SaunaLoginPage(args: args,);
          }),
      SailorRoute(
          name: SLOTS_ROUTE_NAME,
          defaultTransitions: [
            SailorTransition.slide_from_bottom,
            SailorTransition.zoom_in,
          ],
          defaultTransitionCurve: Curves.decelerate,
          defaultTransitionDuration: Duration(milliseconds: 300),
          builder: (context, args, params) {
            return SaunaSlotPage(args: args,);
          }),
      SailorRoute(
          name: SHOP_ROUTE_NAME,
          defaultTransitions: [
            SailorTransition.slide_from_bottom,
            SailorTransition.zoom_in,
          ],
          defaultTransitionCurve: Curves.decelerate,
          defaultTransitionDuration: Duration(milliseconds: 300),
          builder: (context, args, params) {
            return SaunaShopPage(args: args,);
          }),
    ]);
  }
}
