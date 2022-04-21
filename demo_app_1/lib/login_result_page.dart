import 'package:flutter/material.dart';
import 'home_page.dart';

class ResultPage extends StatefulWidget{
  const ResultPage({Key? key, required this.result}) : super(key: key);

  final String result;
  @override
  State<ResultPage> createState() => _ResultPage();
}

class _ResultPage extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Result"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.result),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 25),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                ),
                child: const Text('Home Page'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}