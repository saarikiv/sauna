import 'dart:io' show Platform;
import 'package:http/http.dart' as http; //https://pub.dev/packages/http
import 'dart:convert';
import 'package:sauna/entities/reserve_slot_request.dart';
import 'package:sauna/entities/check_out_request.dart';

const serverUrl = 'https://varausserver-stage.herokuapp.com';
//const serverUrl = 'https://varausserver.herokuapp.com';
//const serverUrl = /*'http://localhost:3000'*/ 'http://10.0.2.2:3000';

const RESERVE_SLOT = '/reserveSlot';
const CHECK_OUT = '/checkout';

class VarausServerService{

  var client = http.Client();
  void dispose(){
    client.close();
  }

  Future<int> cashBuy(CheckOutRequest request) async {
    var url = serverUrl + CHECK_OUT;
    int httpStatusCode = 0;
    try {
      var response = await client.post(url, body: request.toJson());
      httpStatusCode = response.statusCode;
      print('Response status: ' + response.statusCode.toString());
      print('Response body: ${response.body}');
    } catch (error){
      print('CashBuy failed: ' + error.toString());
      httpStatusCode = 555;
    } finally {
      print('try catch finally');
    }
    return httpStatusCode;
  }

  Future<int> reserveSlot(ReserveSlotRequest request) async{
    var url = serverUrl + RESERVE_SLOT;
    int httpStatusCode = 0;
    try {
      final requestBody = request.toJson();
      var response = await client.post(url, body: requestBody);
      httpStatusCode = response.statusCode;
      print('Response status: ' + response.statusCode.toString());
      print('Response body: ${response.body}');
    } catch (error){
      print('ReserveSlot failed: ' + error.toString());
      httpStatusCode = 555;
    } finally {
      print('try catch finally');
    }
    return httpStatusCode;
  }
}
