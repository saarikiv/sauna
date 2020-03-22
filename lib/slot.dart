import 'package:flutter/material.dart';

class Slot {
  bool blocked;
  int start;
  int end;
  String reserver;
  int day;

  Slot.fromDynamic(dynamic data){
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
