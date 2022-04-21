import 'package:flutter/material.dart';
import 'signup_pad_page.dart';

class SignupNamePage extends StatefulWidget {
  const SignupNamePage({Key? key}) : super(key: key);

  @override
  State<SignupNamePage> createState() => _SignupNamePage();
}


class _SignupNamePage extends State<SignupNamePage>{

  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_nameController.text != ""){
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(
              builder: (context) =>  SignupPadPage(myCounter: 10, name: _nameController.text)),
              (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-up Page'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Username:'),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 150,
                    height: 40,
                    child: TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter username',
                        border: InputBorder.none,
                        fillColor: Color(0xFFBFBDBD),
                        filled: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() => _submit());
                    },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.cyan,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  ),
                  child: const Text('Continue'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}