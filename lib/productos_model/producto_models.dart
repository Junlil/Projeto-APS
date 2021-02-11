import 'package:flutter/material.dart';

class ProdutosModelo {
  final String name;
  final String image;
  final Color color;
  final double price;
  int quantity;

  ProdutosModelo(
      {this.name, this.image, this.color, this.price, this.quantity = 1});
}
