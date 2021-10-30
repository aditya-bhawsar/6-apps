import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '6apps'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, Color> colors = {
    'purple': Colors.purple,
    'blue': Colors.blue,
    'yellow': Colors.yellow,
    'pink': Colors.pink,
    'teal': Colors.teal,
    'orange': Colors.orange
  };

  Color? selectedColor;

  @override
  void initState() {
    getColor();
    super.initState();
  }

  void getColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? colorName  = prefs.getString('color');
    setState(() {
      selectedColor = colors[colorName];
    });
  }

  void setColor(String key, Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('color', key);
    setState(() {
      selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: selectedColor ?? Colors.black,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                'You are operating on ${kIsWeb? 'Web' : Platform.operatingSystem}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            for (var color in colors.entries)
              Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: color.value,
                    minimumSize: const Size(300, 60),
                  ),
                  child: const Text(''),
                  onPressed: () => setColor(color.key, color.value),
                ),
              )
          ],
        ),
      ),
    );
  }
}
