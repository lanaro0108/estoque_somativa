import 'package:flutter/material.dart';
import 'package:sa_estoque_somativa/screens/home_screen.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: "Controle de Estoque",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.brown),
    home: HomeScreen(),
  ));
}
