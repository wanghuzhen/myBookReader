import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShelfBookItem extends StatefulWidget {
  final Map bookItem;

  const ShelfBookItem({Key key, this.bookItem}) : super(key: key);

  @override
  _ShelfBookItemState createState() => _ShelfBookItemState();
}

class _ShelfBookItemState extends State<ShelfBookItem> {
  /*
  图书地址 bookUrl;
  书名 bookName;
  图书封面 bookCover;
  作者 author;
  最新章节url lastUrl;
  最新章节标题 lastTitle;
  书籍介绍 intro;
  来源 coming;
  更新时间 time;
  章节数目 characterNum;
  目录 dirList;
  当前章节 currentIndex;
   */

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0),
      height: 144,
      child: GestureDetector(
        onTap: () {
          print(widget.bookItem['bookName']);
        },
        onLongPress: () {
          Navigator.pushNamed(
            context,
            '/introPage',
            arguments: {
              'bookUrl': widget.bookItem['bookUrl'],
              'currentIndex': 0,
            },
          );
        },
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0))),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 6.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                        'http://www.xbiqige.com' + widget.bookItem['bookCover'],
                        fit: BoxFit.cover,
                        width: 92,
                        height: 120)),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.bookItem['bookName'],
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    _buildItem(
                        'images/author.png', '作者：' + widget.bookItem['author']),
                    _buildItem(
                        'images/current.png',
                        widget.bookItem['dirList']
                                [widget.bookItem['currentIndex']]
                            .split('+')[0]),
                    _buildItem('images/last.png', widget.bookItem['lastTitle']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildItem(String imagePath, String text) {
    return Row(
      children: [
        Image(
          image: AssetImage(imagePath),
          width: 11.0,
          height: 11.0,
        ),
        SizedBox(
          width: 6.0,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.black54),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
      textBaseline: TextBaseline.alphabetic,
    );
  }
}
