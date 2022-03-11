import 'package:bank_app/models/card_model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class CardField extends StatelessWidget {
  CardField({Key? key, required this.child}) : super(key: key);

  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage("assets/icons/visa.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade900,
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.2),
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
