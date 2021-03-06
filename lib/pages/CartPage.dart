import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'FavPage.dart';
import 'HomePage.dart';
import 'RegPage.dart';
import 'OrderPage';

final FirebaseAuth _auth = FirebaseAuth.instance;

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  void initState() {
    if (ordered == true) {
      setState(() {
        cart.clear();
        ordered = false;
      });
    }
    super.initState();
  }


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
          trailing: AutoSizeText(
              "\₹${(cart[index].price * cart[index].count).toStringAsFixed(2)}",
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
        iconTheme: IconThemeData(color: Colors.teal),
        backgroundColor: Colors.white,
        elevation: 5.0,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Shopping App',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
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
      drawer: Drawer(
        elevation: 10.0,
        child: ListView(
          children: <Widget>[
            //Here you place your menu items
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.teal,
              ),
              title: Text('Home Page',
                  style: TextStyle(fontSize: 18, color: Colors.teal)),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: HomeScreen(),
                    duration: Duration(milliseconds: 300),
                    reverseDuration: Duration(milliseconds: 300),
                  ),
                );              },
            ),
            Divider(height: 3.0),
            ListTile(
              leading: Icon(Icons.contact_phone, color: Colors.teal),
              title: Text('Contact Us',
                  style: TextStyle(fontSize: 18, color: Colors.teal)),
              onTap: () {
                // Here you can give your route to navigate
              },
            ),
            Divider(height: 3.0),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.teal),
              title: Text('Sign Out',
                  style: TextStyle(fontSize: 18, color: Colors.teal)),
              onTap: () async {
                final User? user = await _auth.currentUser;
                if (!(user == null)) {
                  await _auth.signOut();
                  Fluttertoast.showToast(msg: "Signed out successfully");
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => RegScreen()));
                }
              },
            ),
          ],
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
              child: Text('Your shopping cart: ',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54))),
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
          height: 65.h,
          child: ListView.separated(
            itemBuilder: (ctx, index) => makeitem(index),
            separatorBuilder: (ctx, index) => Divider(color: Colors.grey[300]),
            itemCount: cart.length,
          ),
        ),
        Divider(
          color: Colors.black,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text('Total: ₹${generateTotal().toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        )
      ]),
      bottomSheet: Container(
        height: 10.h,
        color: Colors.teal,
        child: Center(
          child: new InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: OrderPage(),
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 300),
                ),
              );
              },
            child: Text(
              "PLACE ORDER (₹${generateTotal().toStringAsFixed(2)})",
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
