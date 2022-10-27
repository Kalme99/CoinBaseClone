import 'package:flutter/material.dart';
import '../model/coin.dart';

class CoinCard extends StatelessWidget {
  final Coin coin;
  const CoinCard({required this.coin, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          children: [
            Image.network(coin.imageUrl, width: 35),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  coin.fullName,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16),
                ),
                Text(
                  coin.ticker,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 14),
                ),
              ],
            ),
            const Spacer(),
            Text(
              "\$" + coin.price.toStringAsFixed(2),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
