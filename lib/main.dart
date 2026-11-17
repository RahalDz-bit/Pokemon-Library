import 'package:flutter/material.dart';
import 'package:podex/skeleton.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      home: Skeleton(),
    ),
  );
}
