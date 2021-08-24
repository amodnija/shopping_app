import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:sizer/sizer.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  makeitem(int index) {
    return Row(children: [
      Container(
        width: 75.w,
        child: ListTile(
          contentPadding: EdgeInsets.all(20),
          leading: Image.network(
            cart[index].imageUrl,
            height: double.infinity,
            width: 60,
            fit: BoxFit.contain,
          ),
          title: AutoSizeText(cart[index].name,
              minFontSize: 14,
              maxLines: 1,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          subtitle: AutoSizeText("x${cart[index].count}",
              minFontSize: 12,
              maxLines: 2,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          trailing: AutoSizeText("\Rs.${(cart[index].price*cart[index].count).toStringAsFixed(2)}",
              minFontSize: 10,
              maxLines: 1,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
        ),
      ),
      Column(children: [
        FlatButton(
            onPressed: () {
              setState(() {
                cart[index].count += 1;
              });
            },
            child: Icon(Icons.add)),
        FlatButton(
            onPressed: () {
              setState(() {
                if (cart[index].count > 1) {
                  cart[index].count -= 1;
                } else {
                  cart.removeAt(index);
                  Fluttertoast.showToast(msg: "Item removed from cart");
                }
              });
            },
            child: Icon(Icons.remove))
      ])
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Shopping Cart (${cart.length})",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (ctx, index) => makeitem(index),
        separatorBuilder: (ctx, index) => Divider(color: Colors.grey[300]),
        itemCount: cart.length,
      ),
      bottomSheet: Container(
        height: 80,
        color: Colors.orange,
        child: Center(
          child: Text(
            "PLACE ORDER (\$420.69)",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
