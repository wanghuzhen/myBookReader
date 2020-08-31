import 'package:flutter/material.dart';
import 'package:novel_reader/utils/save_data.dart';
import 'dart:ui' as ui show window;
import 'dart:convert';
import 'package:toast/toast.dart';

class IntroToolbar extends StatefulWidget {
  final Map shelfBook;

  const IntroToolbar({
    Key key,
    this.shelfBook,
  }) : super(key: key);
  @override
  _IntroToolbarState createState() => _IntroToolbarState();
}

class _IntroToolbarState extends State<IntroToolbar> {
  bool inBookShelf = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isInBookShelf(widget.shelfBook);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    double bottomSafeHeight = mediaQuery.padding.bottom;
    return Container(
      padding: EdgeInsets.only(bottom: bottomSafeHeight),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 8)]),
      height: 50 + bottomSafeHeight,
      child: Row(children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                if (inBookShelf) {
                  //删除书籍
                  _delBook(widget.shelfBook);
                  print('del successful');
                } else {
                  //加入书籍
                  _addBook(widget.shelfBook);
                  print('add successful');
                }
                inBookShelf = !inBookShelf;
              });
            },
            child: Center(
              child: inBookShelf
                  ? Text(
                      '删除书籍',
                      style: TextStyle(fontSize: 16, color: Colors.redAccent),
                    )
                  : Text(
                      '加入书架',
                      style: TextStyle(fontSize: 16, color: Color(0xFF23B38E)),
                    ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              //TODO
              print('开始阅读');
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Color(0xFF23B38E),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  '开始阅读',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            child: Center(
              child: Text(
                '下载',
                style: TextStyle(fontSize: 16, color: Color(0xFF23B38E)),
              ),
            ),
            onTap: () {
              //todo
              Toast.show('这是凑数的，看起来比较对称', context);
            },
          ),
        ),
      ]),
    );
  }

  Future _delBook(Map book) async {
    List<String> jsonBook = [];
    SharedPreferencesDataUtils sp = SharedPreferencesDataUtils();
    await sp.getUserInfo('shelfBook').then((value) {
      jsonBook.addAll(value);
      for (int i = 0; i < jsonBook.length; i++) {
        if (jsonBook[i].indexOf(book['bookUrl']) != -1) {
          jsonBook.removeAt(i);
          break;
        }
      }
    });
    await sp.setUserInfo('shelfBook', jsonBook);
  }

  Future _addBook(Map book) async {
    List<String> jsonBook = [];
    SharedPreferencesDataUtils sp = SharedPreferencesDataUtils();
    await sp.getUserInfo('shelfBook').then((value) {
      if (value != null) {
        jsonBook.addAll(value);
      } else {
        jsonBook = [];
      }
    });
    jsonBook.add(json.encode(book));
    await sp.setUserInfo('shelfBook', jsonBook);
  }

  Future _isInBookShelf(Map book) async{
    List<String> jsonBook = [];
    SharedPreferencesDataUtils sp = SharedPreferencesDataUtils();
    await sp.getUserInfo('shelfBook').then((value) {
      if(value!=null){
        jsonBook.addAll(value);
        jsonBook.forEach((element) {
          if (element.indexOf(book['bookUrl']) != -1) {
            setState(() {
              inBookShelf = true;
            });
          }
        });
      }
    });
  }
}
