import 'slot.dart';

class ReserveSlotRequest {
  String userToken;
  Slot slot;
  int weeksForward;
  int timezoneOffset;

  ReserveSlotRequest(
      {this.userToken, this.slot, this.weeksForward, this.timezoneOffset});

  dynamic toJson() {
    return '''{
      "user" : "$userToken",
      "slotInfo" : ${slot.toJson()},
      "weeksForward" : $weeksForward,
      "timeZoneOffset" : $timezoneOffset
    }''';
  }
}
