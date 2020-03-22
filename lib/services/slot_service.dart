import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sauna/entities/slot.dart';
import 'sauna_service_args.dart';

class SlotService {

  final SaunaServiceArgs args;
  SlotService({@required this.args});

  List<Slot> slotList = new List<Slot>();

  void clearSlotList(){
    slotList?.clear();
  }

  void processQueryResults(DataSnapshot dataSnapshot){
    clearSlotList();
    Map<dynamic, dynamic> data = dataSnapshot.value;
    data.forEach((key, value) {
      slotList?.add(Slot.fromDynamic(key, value));
    });
  }

  Future<List<Slot>> slotsFromDb() async {
    FirebaseDatabase database = FirebaseDatabase(app: args.firebaseApp, );
    DataSnapshot data = await FirebaseDatabase.instance.reference().child('slots').once();
    processQueryResults(data);
    return slotList;
  }


}