import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sauna/entities/slot.dart';
import 'package:firebase_database/firebase_database.dart';
import 'sauna_view_args.dart';
import 'package:sauna/services/slot_service.dart';
import 'package:provider/provider.dart';

class SaunaSlotPage extends StatefulWidget {
  SaunaSlotPage({Key key, @required this.args}) : super(key: key);
  final SaunaViewArgs args;

  @override
  State<StatefulWidget> createState() {
    return _SaunaSlotPageState();
  }
}

class _SaunaSlotPageState extends State<SaunaSlotPage> {
  SlotService _slotService;

  @override
  void didChangeDependencies() {
    _slotService = Provider.of<SlotService>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'SLOTS',
            ),
            Expanded(
              child: FutureBuilder(
                  initialData: _slotService.slotList,
                  future: _slotService.slotsFromDb(),
                  builder: (context, slotSnapshot) {
                    if (slotSnapshot.hasData) {
                      return StreamBuilder(
                          stream: _slotService.slotReservations(),
                          builder: (context, snap) {
                            if (snap.hasData &&
                                !snap.hasError &&
                                snap.data != null) {
                              _slotService
                                  .processReservationStatus(snap.data.snapshot);
                              print('perskuta rallaa...');
                              return new ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  padding: EdgeInsets.all(10.0),
                                  scrollDirection: Axis.vertical,
                                  controller: ScrollController(
                                    initialScrollOffset: 20.0,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: slotSnapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return slotSnapshot.data[index]
                                        .present(context);
                                  });
                            }
                            return CircularProgressIndicator();
                          });
                    }
                    return CircularProgressIndicator();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
