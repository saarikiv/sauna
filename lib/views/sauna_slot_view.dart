import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sauna/slot.dart';
import 'sauna_basic_args.dart';

class SaunaSlotView extends StatefulWidget {
  SaunaSlotView(
      {Key key, @required this.args})
      : super(key: key);
  final SaunaBasicArgs args;

  @override
  State<StatefulWidget> createState() {
    return _SaunaSlotViewState();
  }
}

class _SaunaSlotViewState extends State<SaunaSlotView> {

  Future<Widget> _readFromDatabase(BuildContext context) async {
    FirebaseDatabase database = FirebaseDatabase(app: widget.args.firebaseApp, );
    DataSnapshot snapshot = await FirebaseDatabase.instance.reference().child('slots').once();
    return fromDynamic(snapshot.value, context);
  }

  Widget fromDynamic(dynamic data, BuildContext context) {
    Map<dynamic, dynamic> values = data;
    values.forEach((key, value) {
      return Slot.fromDynamic(key,value).present(context);
    });
    return Text(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
