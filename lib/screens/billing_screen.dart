import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_tile.dart';

class BillingScreen extends ConsumerWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final total = ref.read(cartProvider.notifier).total;

    return Scaffold(
      appBar: AppBar(title: const Text("Billing")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (_, i) {
                  final item = cart[i];
                  return Column(
                    children: [
                      ProductTile(
                        product: item,
                        onTap: () {
                          ref.read(cartProvider.notifier).removeProduct(item);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${item.name} removed")),
                          );
                        },
                      ),
                      Visibility(
                        visible: cart.indexOf(cart[i]) != cart.length - 1,
                        child: Divider(),
                      ),
                    ],
                  );
                },
              ),
            ),
            Text("Total: ₹$total", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
