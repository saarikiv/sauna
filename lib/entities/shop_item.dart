import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sauna/services/login_service.dart';
import 'package:sauna/services/varausserver_service.dart';
import 'check_out_request.dart';

class ShopItem {
  String _key;
  int beforeTax;
  String desc;
  int expiresAfterDays;
  bool oneTime;
  int price;
  int taxAmount;
  int taxPercent;
  String title;
  String type;
  int useTimes;

  String key() => _key;

 Future<void> _shopItemPressed(BuildContext context) async {
    final loginService = Provider.of<SaunaLoginService>(context, listen: false);
    final varausServerService = Provider.of<VarausServerService>(context, listen: false);
    final tokenResult = await loginService.user.getIdToken(refresh: false);
    final request = CheckOutRequest(
      userToken: tokenResult.token,
      shopItem: this,
    );
    final result = await varausServerService.cashBuy(request);
    print('Cash buy result: ' + result.toString());
  }

  ShopItem.fromDynamic(String key, dynamic data) {
    _key = key;
    beforeTax = data['beforetax'];
    desc = data['desc'];
    expiresAfterDays = data['expiresAfterDays'];
    oneTime = data['oneTime'];
    price = data['price'];
    taxAmount = data['taxamount'];
    taxPercent = data['taxpercent'];
    title = data['title'];
    type = data['type'];
    useTimes = data['usetimes'];
  }

  Widget present(BuildContext context) {
    return Card(
      color: Colors.orange,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              //width: 150,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title),
                  Text('$price€'),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    desc,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: RaisedButton(
                onPressed: () => _shopItemPressed(context),
                child: Icon(
                  Icons.euro_symbol,
                  size: 30,
                ),
              ),
            ),
          ]),
    );
  }
}
