import 'package:app/views/home.dart';
import 'package:flutter/material.dart';

void main(){
  runApp( const MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        fontFamily: 'Sans-serif',
        ),
      home: const HomePage()
      );
  }
}