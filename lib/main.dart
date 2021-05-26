import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //宣告一個GlobalKey
  final key1 = GlobalKey();
  final key2 = GlobalKey();
  final key3 = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          //MediaQuery 取得裝置資訊
          //是因為為了練習所以才會用這種方式判斷, 一般來說會使用Flex來達到旋轉螢幕調整排版的功能
          // child: MediaQuery.of(context).orientation == Orientation.portrait ?
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Counter(_globalKey2),
          //     Counter(_globalKey),//因為有_global所以就算增加或是移除Center Widget, hot-reloaad之後狀態都還是會存在
          //   ],
          // ):
          child: Flex(
        direction: MediaQuery.of(context).orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Counter(48, key1),
          Counter(72, key2),
          Counter(72, key3),
          //因為有_global所以就算增加或是移除Center Widget, hot-reloaad之後狀態都還是會存在
        ],
      )
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Counter(_globalKey2),
          //     Counter(_globalKey),//因為有_global所以就算增加或是移除Center Widget, hot-reloaad之後狀態都還是會存在
          //   ],
          // )
          ),
      floatingActionButton: FloatingActionButton(
        //_globalKey.currentState 教學
        // onPressed: (){
        //   final state = (_globalKey.currentState as _CounterState);
        //
        //   state.setState(() {
        //     state._count++;
        //   });
        // },

        //_globalKey.currentWidget
        // onPressed: (){
        //   final widget = (_globalKey.currentWidget as Counter);
        //   print(widget.fontSize);
        //
        // },

        //_globalKey.currentContext

        onPressed: (){
          [key1, key2, key3].forEach((key) {
            final renderBox = (key.currentContext.findRenderObject() as RenderBox);
            //尺寸
            print(renderBox.size);
            //與邊界的距離
            print(renderBox.localToGlobal(Offset.zero));
          });



        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Counter extends StatefulWidget {

  final double fontSize;

  //讓Counter 這個Widget 支持Key
  //加入[] 表示可選參數
  Counter(this.fontSize, [Key key]) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        "$_count",
        style: TextStyle(fontSize: widget.fontSize),
      ),
      onPressed: () => setState(() => _count++),
    );
  }
}
