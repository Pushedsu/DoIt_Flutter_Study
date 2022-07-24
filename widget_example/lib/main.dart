import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: WidgetApp(),
    );
  }
}

class WidgetApp extends StatefulWidget {
  @override
  _WidgetExampleState createState() => _WidgetExampleState();
}

class _WidgetExampleState extends State<WidgetApp> {
  List _buttonList = ['더하기','빼기','곱하기','나누기']; // 버튼에 표시할 아이템 목록 리스트로 선언.
  List<DropdownMenuItem<String>> _dropDownMenuItems = new List.empty(growable: true); //dropdown 형식 리스트 선언.
  String? _buttonText;
  String sum='';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Widget Example'),),
      body:Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding( //widget들 간의 간격을 만들기 위해
                 padding: EdgeInsets.all(15), //사방으로 여백
                  child: Text('결과: $sum',style: TextStyle(fontSize: 20),),
              ),
              Padding(
                padding: EdgeInsets.only(left:20, right: 20),
                child: TextField(keyboardType: TextInputType.number,controller:value1),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20), //좌우 여백
                 child: TextField(keyboardType: TextInputType.number,controller:value2),
              ),
              Padding(
                  padding: EdgeInsets.all(15),
                   child: ElevatedButton(
                      child: Row(//가로 위젯 배치
                        children: <Widget>[Icon(Icons.add),Text(_buttonText!)],//사용자가 선택한 아이템 표시.
                            ),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
                      onPressed: (){ //onPressed 사용자가 눌렀을 때 이벤트 처리.
                        setState(() { //위젯의 상태를 갱신해주는 함수 해당 데이터가 바뀌면 해당 데이터를 사용하는 모든 위젯에게 알려줌.
                          var value1Int = double.parse(value1.value.text);
                          var value2Int = double.parse(value2.value.text);
                          var result;
                          if(_buttonText=='더하기') {
                            result = value1Int+value2Int;
                          } else if(_buttonText=='빼기'){
                            result = value1Int-value2Int;
                          } else if(_buttonText=='곱하기'){
                            result = value1Int*value2Int;
                          } else if(_buttonText=='나누기'){
                            result = value1Int/value2Int;
                          }
                          sum='$result';
                        });
                      })
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: DropdownButton(items: _dropDownMenuItems, onChanged: (String? value) {
                  setState(() {
                    _buttonText = value;
                  });
                  }, value:_buttonText,), //items -> 표시할 아이템 목록, onChanged 아이템이 바뀔 때 처리할 이벤트
                ),
              ],
            ),
          ),
        ),
      );
    }
    @override
    void initState() {
    super.initState(); //statefulwidget 상태 초기화 함수
      for(var item in _buttonList) { //버튼 리스트에 있는 아이템들을 하나씩 빼서 드랍다운메뉴아이템에 추가
        _dropDownMenuItems.add(DropdownMenuItem(value:item, child: Text(item)));
      }
      _buttonText = _dropDownMenuItems[0].value; //최상단에 있는 아이템이 버튼에 표시할 텍스트
    }
}
