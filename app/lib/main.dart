import 'package:flutter/material.dart';


void main(){

  runApp( MyApp() );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) { // Returns a widget when flutter reloads app
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Vox Manus'),
        ),
        
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            print("pressed");
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            )
          ]
        ),
        drawer: Drawer(
          child: Text('Yo!')
        ),
      ),
    );
  }
}