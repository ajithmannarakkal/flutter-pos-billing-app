import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../providers/cart_provider.dart';
import '../services/firebase_service.dart';
import 'billing_screen.dart';

class ScannerScreen extends ConsumerWidget {
  final FirebaseService service = FirebaseService();

  ScannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Product")),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) {
          final String? code = capture.barcodes.firstOrNull?.rawValue;

          if (code == null) return;

          service.fetchProductByBarCode(code).then((product) {
            if (product != null) {
              ref.read(cartProvider.notifier).addProduct(product);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("${product.name} added")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Product not found")),
              );
            }
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const BillingScreen()),
          );
        },
      ),
    );
  }
}
