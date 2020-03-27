import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sauna/entities/shop_item.dart';
import 'package:firebase_database/firebase_database.dart';
import 'sauna_view_args.dart';
import 'package:sauna/services/shop_item_service.dart';
import 'package:provider/provider.dart';

class SaunaShopPage extends StatefulWidget {
  SaunaShopPage({Key key, @required this.args}) : super(key: key);
  final SaunaViewArgs args;

  @override
  State<StatefulWidget> createState() {
    return _SaunaShopPageState();
  }
}

class _SaunaShopPageState extends State<SaunaShopPage> {
  ShopItemService _shopItemService;

  @override
  void didChangeDependencies() {
    _shopItemService = Provider.of<ShopItemService>(context);
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
              'SHOP ITEMS',
            ),
            Expanded(
              child: FutureBuilder(
                  initialData: _shopItemService.shopItemList,
                  future: _shopItemService.shopItemsFromDb(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return new ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.all(10.0),
                          scrollDirection: Axis.vertical,
                          controller: ScrollController(
                            initialScrollOffset: 20.0,
                          ),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                              return snapshot.data[index].present(context);
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
