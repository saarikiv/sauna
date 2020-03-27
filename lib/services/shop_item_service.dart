import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:sauna/entities/shop_item.dart';
import 'sauna_service_args.dart';

class ShopItemService {
  final SaunaServiceArgs args;

  ShopItemService({@required this.args});

  List<ShopItem> shopItemList = new List<ShopItem>();

  void clearShopItemList() {
    shopItemList?.clear();
  }

  void processQueryResults(DataSnapshot dataSnapshot) {
    clearShopItemList();
    Map<dynamic, dynamic> data = dataSnapshot.value;
    data.forEach((key, value) {
      shopItemList?.add(ShopItem.fromDynamic(key, value));
    });
  }

  Future<List<ShopItem>> shopItemsFromDb() async {
    DataSnapshot data =
    await FirebaseDatabase.instance.reference().child('shopItems').once();
    processQueryResults(data);
    return shopItemList;
  }

}
