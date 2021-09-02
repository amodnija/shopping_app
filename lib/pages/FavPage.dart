import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'CartPage.dart';
import 'RegPage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class FavPage extends StatelessWidget {
  FavPage({Key? key}) : super(key: key);
  makeitem(int index) {
    return ListTile(
      contentPadding: EdgeInsets.all(20),
      leading: Image.network(
        favs[index].imageUrl,
        height: double.infinity,
        width: 100,
        fit: BoxFit.contain,
      ),
      title: Text(favs[index].name),
      trailing: Text("\$${favs[index].price.toStringAsFixed(2)}",
          style: TextStyle(
              color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 16)),
    );
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
        itemCount: favs.length,
      ),
    );
  }
}