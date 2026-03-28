import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';

class FirebaseService {
  final _db = FirebaseFirestore.instance;
  Future<Product?> fetchProductByBarCode(String barcode) async {
    final doc = await _db.collection('products').doc(barcode).get();
    if (doc.exists) {
      return Product.fromMap(doc.id, doc.data()!);
    } else {
      return null;
    }
  }
}
