import 'package:flutter/material.dart';

class BalanceHeader extends StatelessWidget {
  final double balance;
  const BalanceHeader({required this.balance, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total balance",
            style:
                TextStyle(color: Colors.black.withOpacity(.55), fontSize: 15),
          ),
          Text(
            "\$" + balance.toStringAsFixed(2),
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
