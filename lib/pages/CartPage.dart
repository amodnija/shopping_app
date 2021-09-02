import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'FavPage.dart';
import 'RegPage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

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
          trailing: AutoSizeText("\₹${(cart[index].price*cart[index].count).toStringAsFixed(2)}",
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
        backgroundColor: Colors.white,
        elevation: 5.0,
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: InkResponse(
            onTap: () async {
              final User? user = await _auth.currentUser;
              if (!(user == null)) {
                await _auth.signOut();
                Fluttertoast.showToast(msg: "Signed out successfully");
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RegScreen()));
              }
            },
            child: Icon(
              Icons.logout,
              size: 30,
              color: Colors.teal,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Shopping App',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10, right: 20),
                child: InkResponse(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: CartPage(),
                        duration: Duration(milliseconds: 300),
                        reverseDuration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: FavPage(),
                    duration: Duration(milliseconds: 300),
                    reverseDuration: Duration(milliseconds: 300),
                  ),
                );
              },
              child: Icon(
                Icons.favorite,
                size: 30,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (ctx, index) => makeitem(index),
        separatorBuilder: (ctx, index) => Divider(color: Colors.grey[300]),
        itemCount: cart.length,
      ),
      bottomSheet: Container(
        height: 80,
        color: Colors.teal,
        child: Center(
          child: Text(
            "PLACE ORDER (₹${generateTotal().toStringAsFixed(2)})",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
