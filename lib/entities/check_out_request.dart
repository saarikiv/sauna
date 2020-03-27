import 'shop_item.dart';

class CheckOutRequest {
  String userToken;
  ShopItem shopItem;

  CheckOutRequest(
      {this.userToken, this.shopItem});

  dynamic toJson() {
    return '''{
      "current_user" : "$userToken",
      "item_key" : "${shopItem.key()}"
    }''';
  }
}
