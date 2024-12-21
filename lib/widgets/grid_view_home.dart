import 'package:flutter/material.dart';
import 'package:rentit/widgets/ad_banner.dart';
import 'package:rentit/widgets/product_card.dart';
import '../data/dummy_data.dart'; // Import the dummy data file

class GridViewHome extends StatefulWidget {
  const GridViewHome({Key? key}) : super(key: key);

  @override
  State<GridViewHome> createState() => _GridViewHomeState();
}

class _GridViewHomeState extends State<GridViewHome> {
  @override
  Widget build(BuildContext context) {
    int cardsPerCycle = 8;
    int adsPerCycle = 2;
    int totalCycles = 3;
    int totalItems = (cardsPerCycle + adsPerCycle) * totalCycles;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.75,
      ),
      itemCount: totalItems,
      itemBuilder: (_, index) {
        int cycleIndex = index ~/ (cardsPerCycle + adsPerCycle);
        int localIndex = index % (cardsPerCycle + adsPerCycle);

        if (localIndex >= cardsPerCycle) {
          // Insert banners
          return BannerAdWidget();
        } else {
          // Insert cards
          final itemIndex =
              (cycleIndex * cardsPerCycle + localIndex) % products.length;
          final product = products[itemIndex];
          return ProductCard(
            product: product, // Pass the entire product object
          );
        }
      },
    );
  }
}
