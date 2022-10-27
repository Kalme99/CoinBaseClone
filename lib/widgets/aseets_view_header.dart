import 'package:flutter/material.dart';

class AssetsViewHeader extends StatelessWidget {
  const AssetsViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 15.0, bottom: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Top assets",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: const [
              Text(
                "View all",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
        ],
      ),
    );
  }
}
