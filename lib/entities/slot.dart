import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sauna/services/varausserver_service.dart';
import 'package:sauna/services/login_service.dart';
import 'package:provider/provider.dart';
import 'reserve_slot_request.dart';

class Slot {
  String _key;
  bool blocked;
  int start;
  int end;
  String reserver;
  int day;

  Slot();

  String key() => _key;

  int defineWeeksForward(){
    final time = DateTime.now();
    final wDay = day==0? 7 : day;
    if(time.weekday > wDay) return 1;
    if(time.weekday < wDay) return 0;
    //days match reservation is for today
    int dTime = time.hour * 60 * 60 * 1000;
    if(dTime > start) return 1;
    return 0;
  }

  int defineTimezoneOffset(){
    final time = DateTime.now();
    return time.timeZoneOffset.inMilliseconds;
  }

  Future<void> _slotPressed(BuildContext context) async {
    final varausServerService = Provider.of<VarausServerService>(context, listen: false);
    final loginService = Provider.of<SaunaLoginService>(context, listen: false);
    final tokenResult = await loginService.user.getIdToken(refresh: false);

    ReserveSlotRequest request = ReserveSlotRequest(
      slot: this,
      timezoneOffset: defineTimezoneOffset(),
      weeksForward: defineWeeksForward(),
      userToken: tokenResult.token,
    );

    final result = await varausServerService.reserveSlot(request);
    print('Result of reservation: ' + result.toString());

  }

  String toJson(){
    return '''{
      "key" : "$_key",
      "start" : $start,
      "day" : $day
    }''';
  }

  Slot.fromDynamic(String key, dynamic data) {
    _key = key;
    blocked = data['blocked'];
    start = data['start'];
    end = data['end'];
    reserver = data['reserver'];
    day = data['day'];
  }

  String timeStr(int timeInt) {
    final hours = timeInt ~/ 3600000;
    final minutes = '00';
    final time = hours.toString() + ':' + minutes.toString();
    return time;
  }

  String dayOfTheWeek(int day) {
    final days = [
      'Sunnuntai',
      'Maanantai',
      'Tiistai',
      'Keskiviikko',
      'Torstai',
      'Perjantai',
      'Lauantai',
    ];
    return days[day];
  }

  Widget present(BuildContext context) {
    return Card(
      color: reserver.length > 0 ? Colors.blue : Colors.lightGreen,
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
                  Text(dayOfTheWeek(day)),
                  Text(timeStr(start) + ' - ' + timeStr(end)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(reserver),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: RaisedButton(
                onPressed: () => _slotPressed(context),
                child: Icon(
                  blocked ? Icons.block : Icons.check,
                  size: 30,
                ),
              ),
            ),
          ]),
    );
  }
}
