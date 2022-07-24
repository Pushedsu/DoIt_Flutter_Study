import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; //파일을 내려 받는데 도움을 주는 패키지
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() => runApp(LargeFileMain());

class LargeFileMain extends StatefulWidget {
  const LargeFileMain({Key? key}) : super(key: key);

  @override
  State<LargeFileMain> createState() => _LargeFileMainState();
}

class _LargeFileMainState extends State<LargeFileMain> {
  //final imgUrl='https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg?auto=compress'; 이미지 주소
  TextEditingController? _editingController;
  bool downloading = false; // 지금 내려받는 중인지 확인하는 변수
  var progressingString= ""; //현재 얼마만큼 내려 받았는지 확인하는 변수
  String file = ""; //내려받은 파일
  @override
  initState(){
    super.initState();
    _editingController = new TextEditingController(text:'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg?auto=compress');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'url 입력하세요'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          downloadFile();
        },
        child: Icon(Icons.file_download),
      ),
      body: Center(
        child: downloading?
        Container(
          height: 120.0,
          width: 200.0,
          child: Card(
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Downloading File:$progressingString',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ): FutureBuilder(
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.none:
                print('none');
                return Text('데이터 없음.');
              case ConnectionState.waiting:
                print('waiting');
                return CircularProgressIndicator();
              case ConnectionState.active:
                print('active');
                return CircularProgressIndicator();
              case ConnectionState.done:
                print('done');
                if(snapshot.hasData){
                  return snapshot.data as Widget;
                }
            }
            print('end progress');
            return Text('데이터 없음');
          }, future: downloadWidget(file),
        ),
      ),
    );
  }
  Future<void> downloadFile() async{
    Dio dio = Dio();
    try{
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(_editingController!.value.text, '${dir.path}/myimage.jpg',
          onReceiveProgress: (rec,total){
            print('Rec:$rec,Total:$total');
            file = '${dir.path}/myimage.jpg';
            setState((){
              downloading =true;
              progressingString=((rec/total)*100).toStringAsFixed(0)+'%';
            });
          });
    } catch(e){
      print(e);
    }
    setState((){
      downloading = false;
      progressingString = 'Completed';
    });
    print('Download complted');
  }
  Future<Widget> downloadWidget(String filePath) async{
    File file = File(filePath);
    bool exist = await file.exists();
    new FileImage(file).evict();

    if(exist){
      return Center(
        child: Column(
          children: <Widget>[Image.file(File(filePath))],
        ),
      );
    } else{
      return Text('No Data');
    }
  }
}