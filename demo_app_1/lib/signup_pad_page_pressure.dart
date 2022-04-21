import 'package:flutter/material.dart';
import 'login_result_page.dart';
import 'dart:developer';

class LoginPadPagePressure extends StatefulWidget {
  const LoginPadPagePressure({Key? key, required this.name}) : super(key: key);

  final String name;
  @override
  State<LoginPadPagePressure> createState() => _LoginPadPagePressure();
}

class _LoginPadPagePressure extends State<LoginPadPagePressure>{
  String _number = '';
  String xPosition = '';
  String yPosition = '';
  String clickPressure = '';
  int time = 0;

  // used to store data for each pin-code entry
  List<double> xLoc = [];
  List<double> yLoc = [];
  List<double> pressure = [];
  List<int> times = [];

  final timer = Stopwatch();

  void _updateNumber(String digit) {
    setState(() {
      log('added number: $digit');
      _number = _number + digit;
      if (timer.isRunning) {
        timer.stop();
        time = timer.elapsedMicroseconds;
        times.add(time);
      }
      // appending data to lists
      xLoc.add(double.parse(xPosition));
      yLoc.add(double.parse(yPosition));
      //pressure.add(double.parse(clickPressure));
      timer.reset();
      timer.start();
    });
  }

  void _submit() {
    setState(() {
      if (timer.isRunning) {
        timer.stop();
      }
      // printing data gathered
      log('$xLoc');
      log("$yLoc");
      log("$pressure");
      log("$times");
      if (_number=="123456"){
        _number = '';
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const ResultPage(result: "Login Successful")));
      } else {
        _number = '';
        // TODO add data to pin array
        // TODO write pin array to json file
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const ResultPage(result: "Login Failed")));
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: const Text('Enter Pin'),
          centerTitle: true,
          backgroundColor: Colors.cyan,
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(_number)
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: GridView.count(
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    crossAxisCount: 3,
                    children: [
                      GestureDetector(
                        onForcePressStart: (ForcePressDetails details){
                          setState(() {
                            xPosition = '${details.globalPosition.dx.floorToDouble()}';
                            yPosition = '${details.globalPosition.dy.floorToDouble()}';
                            clickPressure = '${details.pressure}';
                          });
                          log("onPressure");
                          log('Positions: $xPosition and $yPosition');
                          log('Pressure: $clickPressure');
                          Feedback.forTap(context);
                        },
                        child: ElevatedButton(
                          onPressed: () => _updateNumber('1'),
                          child: const Text('1'),
                        ),
                      ),
                      GestureDetector(
                        onLongPressStart: (LongPressStartDetails details){
                          setState(() {
                            xPosition = '${details.globalPosition.dx.floorToDouble()}';
                            yPosition = '${details.globalPosition.dy.floorToDouble()}';
                          });
                          log("onLongPress");
                          log('$xPosition and $yPosition');
                          Feedback.forTap(context);
                          _updateNumber('2');
                        },
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('2'),
                        ),
                      ),
                      GestureDetector(
                        onTapDown: (TapDownDetails details){
                          setState(() {
                            xPosition = '${details.globalPosition.dx.floorToDouble()}';
                            yPosition = '${details.globalPosition.dy.floorToDouble()}';
                          });
                          log("onTapDown");
                          log('$xPosition and $yPosition');
                          Feedback.forTap(context);
                        },
                        onTap: (){
                          log('onTap');
                        },
                        child: ElevatedButton(
                          onPressed: () => _updateNumber('3'),
                          child: const Text('3'),
                        ),
                      ),
                      GestureDetector(
                        onForcePressStart: (ForcePressDetails details){
                          setState(() {
                            xPosition = '${details.globalPosition.dx.floorToDouble()}';
                            yPosition = '${details.globalPosition.dy.floorToDouble()}';
                            clickPressure = '${details.pressure}';
                          });
                          log('Positions: $xPosition and $yPosition');
                          log('Pressure: $clickPressure');
                          Feedback.forTap(context);
                          _updateNumber('4');
                        },
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('4'),
                        ),
                      ),
                      GestureDetector(
                        onForcePressStart: (ForcePressDetails details){
                          setState(() {
                            xPosition = '${details.globalPosition.dx.floorToDouble()}';
                            yPosition = '${details.globalPosition.dy.floorToDouble()}';
                            clickPressure = '${details.pressure}';
                          });
                          log('Positions: $xPosition and $yPosition');
                          log('Pressure: $clickPressure');
                          Feedback.forTap(context);
                          _updateNumber('5');
                        },
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('5'),
                        ),
                      ),
                      GestureDetector(
                        onForcePressStart: (ForcePressDetails details){
                          setState(() {
                            xPosition = '${details.globalPosition.dx.floorToDouble()}';
                            yPosition = '${details.globalPosition.dy.floorToDouble()}';
                            clickPressure = '${details.pressure}';
                          });
                          log('Positions: $xPosition and $yPosition');
                          log('Pressure: $clickPressure');
                          Feedback.forTap(context);
                          _updateNumber('6');
                        },
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('6'),
                        ),
                      ),
                      GestureDetector(
                        onForcePressStart: (ForcePressDetails details){
                          setState(() {
                            xPosition = '${details.globalPosition.dx.floorToDouble()}';
                            yPosition = '${details.globalPosition.dy.floorToDouble()}';
                            clickPressure = '${details.pressure}';
                          });
                          log('Positions: $xPosition and $yPosition');
                          log('Pressure: $clickPressure');
                          Feedback.forTap(context);
                          _updateNumber('7');
                        },
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('7'),
                        ),
                      ),
                      GestureDetector(
                        onForcePressStart: (ForcePressDetails details){
                          setState(() {
                            xPosition = '${details.globalPosition.dx.floorToDouble()}';
                            yPosition = '${details.globalPosition.dy.floorToDouble()}';
                            clickPressure = '${details.pressure}';
                          });
                          log('Positions: $xPosition and $yPosition');
                          log('Pressure: $clickPressure');
                          Feedback.forTap(context);
                          _updateNumber('8');
                        },
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('8'),
                        ),
                      ),
                      GestureDetector(
                        onForcePressStart: (ForcePressDetails details){
                          setState(() {
                            xPosition = '${details.globalPosition.dx.floorToDouble()}';
                            yPosition = '${details.globalPosition.dy.floorToDouble()}';
                            clickPressure = '${details.pressure}';
                          });
                          log('Positions: $xPosition and $yPosition');
                          log('Pressure: $clickPressure');
                          Feedback.forTap(context);
                          _updateNumber('9');
                        },
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('9'),
                        ),
                      ),
                      const SizedBox(),
                      GestureDetector(
                        onForcePressStart: (ForcePressDetails details){
                          setState(() {
                            xPosition = '${details.globalPosition.dx.floorToDouble()}';
                            yPosition = '${details.globalPosition.dy.floorToDouble()}';
                            clickPressure = '${details.pressure}';
                          });
                          log('Positions: $xPosition and $yPosition');
                          log('Pressure: $clickPressure');
                          Feedback.forTap(context);
                          _updateNumber('0');
                        },
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('0'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                child: ElevatedButton(
                  onPressed: () => _submit(),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFE85454),
                  ),
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        )
    );
  }
}