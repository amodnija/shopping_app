import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app/models/product_model.dart';
import 'package:sizer/sizer.dart';
import 'package:page_transition/page_transition.dart';

import 'CartPage.dart';
import 'FavPage.dart';
import 'HomePage.dart';
import 'RegPage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class NewProdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddProdPage(),
    );
  }
}

class AddProdPage extends StatefulWidget {
  AddProdPage({Key? key}) : super(key: key);

  @override
  _AddProdPageState createState() => _AddProdPageState();
}

class _AddProdPageState extends State<AddProdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.teal),
        backgroundColor: Colors.white,
        elevation: 5.0,
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
                );
              },
            ),
            Divider(height: 3.0),
            ListTile(
              leading: Icon(Icons.add, color: Colors.teal),
              title: Text('Add Product',
                  style: TextStyle(fontSize: 18, color: Colors.teal)),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: NewProdPage(),
                    duration: Duration(milliseconds: 300),
                    reverseDuration: Duration(milliseconds: 300),
                  ),
                );
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => RegScreen()));
                }
              },
            ),
          ],
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        return ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16),
          children: <Widget>[_AddProductForm()],
        );
      }),
    );
  }
}

class _AddProductForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<_AddProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool success = false;

  void _addProduct() async {
    String name = _nameController.text;
    double price = double.parse(_priceController.text);
    String imageUrl = _imageUrlController.text;

    firestoreInstance
        .collection("products")
        .doc("${products!.length + 1}")
        .set({
      "name": name,
      "price": price,
      "imageUrl": imageUrl,
      "description": "",
    }).then((_) {
      Fluttertoast.showToast(msg: "Product Added");
    });
    setState(() {
      Navigator.pop(context);
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: HomeScreen(),
            inheritTheme: true,
            ctx: context),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: 'Image Url'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                onPrimary: Colors.white,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _addProduct();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    const Text('Add Product', style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
