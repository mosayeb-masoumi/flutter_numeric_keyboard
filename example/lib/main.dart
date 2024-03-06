import 'package:flutter/material.dart';
import 'package:flutter_numeric_keyboard/flutter_numeric_keyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter numeric keyboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade200,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        // child: Center(child: FlutterNumericKeyboard(),),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            FlutterNumericKeyboard(
                width: 300,
                height: 400,
                showResult: true,
                resultTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                resultFunction: (value) {
                  print(value);
                },
                obscureResult: false,
                showDivider: true,
                rightIconBack: const Icon(
                  Icons.backspace,
                  color: Colors.blueGrey,
                ),
                showRightIcon: true,
                leftIconReset: const Icon(
                  Icons.refresh,
                  color: Colors.blueGrey,
                ),
                showLeftIcon: true,
                digitStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                backgroundColor: Colors.white,
                backgroundRadius: 20),
          ],
        ),
      ),

    );
  }
}
