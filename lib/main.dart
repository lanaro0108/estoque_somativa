import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sa_petshop_sqlite/screens/home_screen.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: "PetShop SqLite",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.brown),
    home: HomeScreen(),
  ));
}