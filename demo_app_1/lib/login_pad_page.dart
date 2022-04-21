import 'package:flutter/material.dart';
import 'login_result_page.dart';
import 'dart:developer';
import "dart:io";
import "package:csv/csv.dart" as cvs;
import "package:path_provider/path_provider.dart";
import "package:permission_handler/permission_handler.dart";

class LoginPadPage extends StatefulWidget {
  const LoginPadPage({Key? key, required this.name}) : super(key: key);

  final String name;
  @override
  State<LoginPadPage> createState() => _LoginPadPage();
}

class _LoginPadPage extends State<LoginPadPage>{
  String _number = '';
  String xPosition = '';
  String yPosition = '';
  int time = 0;

  // used to store data for each pin-code entry
  List<double> xLoc = [];
  List<double> yLoc = [];
  List<int> times = [];

  List<Widget> buttons =  [];
  List<int> numbers = [1,2,3,4,5,6,7,8,9,0];

  final timer = Stopwatch();

  void _updateNumber(String digit) {
    setState(() {
      _number = _number + digit;
      if (timer.isRunning) {
        timer.stop();
        time = timer.elapsedMicroseconds;
        times.add(time);
      }
      // appending data to lists
      xLoc.add(double.parse(xPosition));
      yLoc.add(double.parse(yPosition));
      timer.reset();
      timer.start();
    });
  }

  void getPermission() async{
    (await Permission.storage.request().isGranted);
  }

  void createDir(final data) async{
    String dir = (await getExternalStorageDirectory())!.path + "/testDataFile.csv";
    File dataFile = File(dir);
    if(!File(dir).existsSync()){
      List<List<String>> headersList = [
        ["x1","x2","x3","x4","x5","x6",
          "y1","y2","y3","y4","y5","y6",
          "t1","t2","t3","t4","t5","name"]
      ];
      final headers = const cvs.ListToCsvConverter().convert(headersList);
      dataFile.writeAsStringSync(headers + "\n", mode:FileMode.append);
    }
    dataFile.writeAsStringSync(data + "\n", mode:FileMode.append);
  }

  void _submit() {
    setState(() {
      if (timer.isRunning) {
        timer.stop();
      }
      List<List<dynamic>> whole = [[]];
      whole[0].addAll(xLoc);
      whole[0].addAll(yLoc);
      whole[0].addAll(times);
      whole[0].add(widget.name);
      final wholeData = const cvs.ListToCsvConverter().convert(whole);
      getPermission();
      createDir(wholeData);
      if (_number=="123456"){
        _number = '';
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const ResultPage(result: "Login Successful")));
      } else {
        _number = '';
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const ResultPage(result: "Login Failed")));
      }
    });
  }

  List<Widget> createNumberPad(){
    for(int i = 0; i< 10; i++){
      if(numbers[i] == 0){
        buttons.add(const SizedBox());
      }
      buttons.add(
        GestureDetector(
            onTapDown: (TapDownDetails details){
              setState(() {
                xPosition = '${details.globalPosition.dx.floorToDouble()}';
                yPosition = '${details.globalPosition.dy.floorToDouble()}';
              });
              //log('Positions: $xPosition and $yPosition');
              Feedback.forTap(context);
              _updateNumber(numbers[i].toString());
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.cyan,
              ),
              child:  Center(
                  child: Text(numbers[i].toString())),
            )
        ),
      );
    }
    return buttons;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(_number)
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: Center(
                    child: GridView.count(
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      crossAxisCount: 3,
                      children: createNumberPad(),
                    ),
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