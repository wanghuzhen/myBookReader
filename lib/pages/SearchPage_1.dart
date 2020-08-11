//第一种SearchPage实现方式,搜索框短，但是使用自带AppBar实现
//自动适配刘海、状态栏

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController(); // 搜索关键词
  bool showClear = false;
  Color inputBoxColor = Color(0xffEDEDED);
  Widget _searchField() {
    return Container(
      margin: EdgeInsets.only(top: 6),
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: inputBoxColor, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: <Widget>[
          Icon(Icons.search, size: 20, color: Color(0xffA9A9A9)),
          Expanded(
              flex: 1,
              child: TextField(
                controller: _controller,
                onChanged: (String text) {},
                autofocus: false,
                style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, -20, 5, 0),
                    border: InputBorder.none,
                    hintText: '小说名/作者名' ?? '',
                    hintStyle: TextStyle(fontSize: 15)),
                enableInteractiveSelection: false,
              )),
          _wrapTap(
              Icon(
                Icons.clear,
                size: 22,
                color: Colors.grey,
              ), () {
            setState(() {
              _controller.clear();
            });
          })
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }

  Widget _buildAppBar() {
    return PreferredSize(
      child: AppBar(
        leading: Container(
          height: 20,
          width: 20,
//          color: Colors.red,
          padding: EdgeInsets.only(top: 5,),
          child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black54,
                size: 26,
              ),
              onPressed: () {
//                Navigator.of(context).pop('/');
              }),
        ),
        title: _searchField(),
        actions: <Widget>[
          Container(
//            color: Colors.red,
            width: 60,
            height: 20,
            padding: EdgeInsets.only(top: 5, right: 20),
            alignment: Alignment(0, 0),
            child: FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 2),
              colorBrightness: Brightness.light,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Text(
                '搜索',
                style: TextStyle(color: Colors.black54, fontSize: 17.0),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
      preferredSize: Size.fromHeight(60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: _buildAppBar(),
      ),
    );
  }
}
