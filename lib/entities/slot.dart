import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Slot {
  String _key;
  bool blocked;
  int start;
  int end;
  String reserver;
  int day;

  Slot();

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
      color: reserver.length > 0? Colors.blue : Colors.lightGreen,
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
          child: Icon(
            blocked ? Icons.block : Icons.check,
            size: 30,
          ),
        ),
      ]),
    );
  }
}
