import 'package:flutter/material.dart';
import 'package:validationform/src/bloc/provider.dart';
import 'package:validationform/src/pages/home_page.dart';
import 'package:validationform/src/pages/login_page.dart';
import 'package:validationform/src/pages/product_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child:
     MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login'    : (BuildContext context) => LoginPage(),
        'home'     : (BuildContext context) => HomePage(),
        'producto' : (BuildContext context) => ProductPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple 
      ),
    ),
    );
  }
}