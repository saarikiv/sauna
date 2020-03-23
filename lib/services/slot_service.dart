import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sauna/entities/slot.dart';
import 'sauna_service_args.dart';

class SlotService {
  final SaunaServiceArgs args;

  SlotService({@required this.args});

  List<Slot> slotList = new List<Slot>();

  void clearSlotList() {
    slotList?.clear();
  }

  void processQueryResults(DataSnapshot dataSnapshot) {
    clearSlotList();
    Map<dynamic, dynamic> data = dataSnapshot.value;
    data.forEach((key, value) {
      slotList?.add(Slot.fromDynamic(key, value));
    });
    slotList.sort((s1, s2) {
      var comp = s1.day - s2.day;
      if(comp == 0) comp = s1.start - s2.start;
      return comp;
    });
  }

  Future<List<Slot>> slotsFromDb() async {
    FirebaseDatabase database = FirebaseDatabase(
      app: args.firebaseApp,
    );
    DataSnapshot data =
        await FirebaseDatabase.instance.reference().child('slots').once();
    processQueryResults(data);
    return slotList;
  }
}
