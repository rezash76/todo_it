import 'package:flutter/material.dart';

class UpLogin extends StatelessWidget {
  const UpLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Positioned(
            right: -150,
            top: -25,
            child: Container(
              width: width / 1.4,
              height: width / 1.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width / 1.4),
                color: Colors.pinkAccent,
              ),
            ),
          ),
          Positioned(
            left: width * 0.3,
            top: -30,
            child: Container(
              width: width / 1.6,
              height: width / 1.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width / 1.6),
                color: Colors.purple,
              ),
            ),
          ),
          Positioned(
            left: -65,
            top: -30,
            child: Container(
              width: width / 1.4,
              height: width / 1.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width / 1.4),
                color: const Color.fromARGB(255, 8, 148, 80),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
