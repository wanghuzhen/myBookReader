import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:novel_reader/components/shelf_book_item.dart';
import 'package:novel_reader/utils/save_data.dart';

class BookShelfCmp extends StatefulWidget {
  @override
  _BookShelfCmpState createState() => _BookShelfCmpState();
}

class _BookShelfCmpState extends State<BookShelfCmp> {
  bool isBookDataEmpty = true;
  List<Map> bookItem = [];

  @override
  void initState() {
    super.initState();
    _fetchBookList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        //todo 书架获取书籍项
        child: isBookDataEmpty
            ? Text(
                '书架空空',
                style: TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              )
            : ListView.builder(
                itemCount: bookItem.length,
                itemBuilder: (BuildContext context, int index) {
                  return ShelfBookItem(
                    bookItem: bookItem[index],
                  );
                }),
      ),
    );
  }

  Future _fetchBookList() async {
    List<String> temp = [];
    SharedPreferencesDataUtils sp = SharedPreferencesDataUtils();
    await sp.getUserInfo('shelfBook').then((value) {
      if (value != null) {
        temp.addAll(value);
        temp.forEach((element) {
          bookItem.add(json.decode(element));
        });
      }
    });
    setState(() {
      isBookDataEmpty = (bookItem.length == 0);
    });
  }
}
