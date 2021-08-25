import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String imageUrl;
  String name;
  double price;
  String description;
  int count = 1;

  Product({
    this.imageUrl: '',
    this.name: '',
    this.price: 0,
    this.description: '',
  });

}

final firestoreInstance = FirebaseFirestore.instance;
Future<List<Product>?> getData() async {
  List<Product> products = [];
  await firestoreInstance.collection("products").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      products.add(Product(
          name: result.data()['name'],
          imageUrl: result.data()['imageUrl'],
          price: result.data()['price'],
          description: result.data()['description']));
    });
  });
  return products;
}
List<Product> cart = [];
List<Product> favs = [];
List<Product>? products = [];

