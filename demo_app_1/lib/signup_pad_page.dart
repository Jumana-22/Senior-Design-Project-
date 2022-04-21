import 'package:flutter/material.dart';
import 'home_page.dart';
import 'dart:developer';
import "dart:io";
import "package:csv/csv.dart" as cvs;
import "package:path_provider/path_provider.dart";
import "package:permission_handler/permission_handler.dart";

class SignupPadPage extends StatefulWidget {
  const SignupPadPage({Key? key, required this.myCounter, required this.name}) : super(key: key);

  final String name;
  final int myCounter;
  @override
  State<SignupPadPage> createState() => _SignupPadPage();
}

class _SignupPadPage extends State<SignupPadPage>{
  int _counter = 0;
  String _number = '';
  String xPosition = '';
  String yPosition = '';
  int time = 0;

  List<dynamic> xLoc = [];
  List<double> yLoc = [];
  List<int> times = [];
  List<List<dynamic>> whole = [[]];

  List<Widget> buttons =  [];
  List<int> numbers = [1,2,3,4,5,6,7,8,9,0];

  final timer = Stopwatch();

  @override
  initState() {
    _counter = widget.myCounter;
    super.initState();
  }

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
    String dir = (await getExternalStorageDirectory())!.path + "/dataFile.csv";
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

  void addData(){
    // saving data in list
    int index = widget.myCounter - _counter;
    log("$index");
    if(index == 0) {
      whole[index].addAll(xLoc);
    } else {
      whole.add(xLoc);
    }
    whole[index].addAll(yLoc);
    whole[index].addAll(times);
    whole[index].add(widget.name);
    log("$whole");
  }

  void _submit() {
    setState(() {
      if (timer.isRunning) {
        timer.stop();
      }
      if (_number == "123456"){
        addData();
        _counter = _counter - 1;
        if (_counter == 0){
          // saving data to file
          final wholeData = const cvs.ListToCsvConverter().convert(whole);
          getPermission();
          createDir(wholeData);
          // going back to home page
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(
                  builder: (context) => const HomePage()),
                  (Route<dynamic> route) => false);
        }
      }
      // clearing lists for next entry
      _number = "";
      xLoc = [];
      yLoc = [];
      times = [];
      timer.reset();
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
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Enter "123456"'),
                    Text("Left: $_counter"),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(5),
                  child: Text(_number)
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: GridView.count(
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    crossAxisCount: 3,
                    children: createNumberPad(),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 15),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => _submit());
                  },
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