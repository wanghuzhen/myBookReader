//第二种SearchPage实现方式，搜索框长，自定义AppBar
//需要获取手机的刘海、状态栏，可能会出现不适配情况

import 'package:flutter/material.dart';
import 'package:novel_reader/components/search_bar.dart';
import 'package:toast/toast.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: [
            _appBar(),
            //TODO--历史记录和热门
          ],
        ),
      ),
    );
  }

  _appBar() {
    final _topPadding = MediaQuery.of(context).padding.top.ceilToDouble();
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ],
        gradient: LinearGradient(
          colors: [Color(0x66000000), Colors.transparent],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(top: _topPadding),
        height: _topPadding + 60.0,
        decoration: BoxDecoration(color: Colors.white),
        child: SearchBar(
          hideLeft: true,
          defaultText: '',
          hint: '小说名/作者名',
          controller: _controller,
          leftButtonClick: () {
            Navigator.pop(context,'/');
          },
          rightButtonClick: () {
            if (_controller.text == '') {
              Toast.show('搜索内容不可为空', context,
                  backgroundRadius: 5.0, backgroundColor: Colors.black45);
            } else {
              print(_controller.text);
            }
          },
          onSubmit: _onSubmit(_controller.text),
        ),
      ),
    );
  }

  _onSubmit(String text) {
    print(text);
  }
}
