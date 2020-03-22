import 'package:flutter/material.dart';

class Slot {
  String _key;
  bool blocked;
  int start;
  int end;
  String reserver;
  int day;

  Slot();

  factory Slot.p(BuildContext context){
    final slot = Slot();
    slot._key = 'undefined';
    return slot;
  }

  Slot.fromDynamic(String key, dynamic data){
    _key = key;
    blocked = data['blocked'];
    start = data['start'];
    end = data['end'];
    reserver = data['reserver'];
    day = data['day'];
  }

  Widget present(BuildContext context){
    return Container(
      child: Row(
        children: <Widget>[
          Icon(
            blocked? Icons.block : Icons.beenhere,
            color: Colors.black,
          ),
          Text(reserver),
        ],
      ),
    );
  }
}
