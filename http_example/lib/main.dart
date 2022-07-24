import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; //json 데이터 불러오기 위한 convert 패키지

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget {

  @override
  State<HttpApp> createState() => _HttpAppState();
}

class _HttpAppState extends State<HttpApp> {
  String result='';
  List? data;
  TextEditingController? _editingController;
  ScrollController? _scrollController;
  int page=1;

  @override
  initState(){ //data 초기화
    super.initState();
    data=new List.empty(growable: true);
    _editingController = new TextEditingController();
    _scrollController = new ScrollController();

    _scrollController!.addListener(() {
      if(_scrollController!.offset >= _scrollController!.position.maxScrollExtent && !_scrollController!.position.outOfRange) {
        print('bottom');
        page++;
        getJsonData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: '검색어를 입력하세요.'),
        ),
      ),
      body: Container(
        child: Center(
          child: data!.length == 0
              ?Text('데이터가 없습니다.',style: TextStyle(fontSize: 20), textAlign: TextAlign.center)
              :ListView.builder(itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.network( //네크워크에 있는 이미지를 가져오는 위젯
                          data![index]['thumbnail'],
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width-150,
                              child: Text(
                                data![index]['title'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text('저자: ${data![index]['authors'].toString()}'),
                            Text('가격: ${data![index]['sale_price'].toString()}'),
                            Text('판매중: ${data![index]['status'].toString()}'),
                          ],
                        )
                      ],
                    ),
                  ),
                );
          },itemCount: data!.length,controller: _scrollController,)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          page=1;
          data!.clear();
          getJsonData(); //getJsonData 함수 호출
        },
        child: Icon(Icons.file_download),
      ),
    );
  }
  Future<String> getJsonData() async{ //Json data 받는 함수 -> 비동기 처리 future 비동기처리에서 바로 받을수 없을때 사용
    var Url='https://dapi.kakao.com/v3/search/book?target=title&page=$page&query=${_editingController!.value.text}';
    var response = await http.get(Uri.parse(Url),
        headers: {"Authorization": "KakaoAK d1f67612c54450632e21a854e24f9c58"});
    //print(response.body); Json 형태로 출력!
    setState((){ // 상태 변화 함수
      var dataConvertedtoJson = json.decode(response.body);
      List result = dataConvertedtoJson['documents'];
      data!.addAll(result);
    });
    return response.body;
  }
}

