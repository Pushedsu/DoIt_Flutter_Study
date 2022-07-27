import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fileApp',
      home: _MyApp(),
    );
  }
}

class _MyApp extends StatefulWidget {
  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  int _count = 0;

  void initState() {
    super.initState();
    readCountFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('File Example'),
        ),
        body: Container(
          child: Center(
            child: Text(
              '$_count',
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _count++;
            });
            writeCountFile(_count);
            },
          child: Icon(Icons.add),
        ),
    );
  }
  void writeCountFile(int count) async{
    var dir = await getApplicationDocumentsDirectory(); // 내부저장소 경로를 불러와 그곳에서 읽거나 씀
    File(dir.path + '/count.txt').writeAsStringSync(count.toString());
  }

  void readCountFile() async{
    try {
      var dir = await getApplicationDocumentsDirectory();
      var file = await File(dir.path + '/count.txt').readAsString();
      print(file);
      setState(() {
        _count = int.parse(file);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
