import 'package:flutter/material.dart';

class BookItem extends StatefulWidget {
  final int index;
  final int netApiId;
  final List list;
  const BookItem({Key key, this.index, this.netApiId, this.list})
      : super(key: key);
  @override
  _BookItemState createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  @override
  Widget build(BuildContext context) {
    List<String> api = [
      'http://www.xbiqige.com',
      '',
      '',
    ];
    return GestureDetector(
      child: Container(
        height: 144,
        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
        child: Card(
          elevation: 3.0,
          color: Color(0xffffffff),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0))),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                        api[widget.netApiId] +
                            widget.list[widget.index].bookCover,
                        fit: BoxFit.cover,
                        width: 92,
                        height: 120)),
              ),
              Expanded(
                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //书名/作者名
                    Container(
                      margin: EdgeInsets.only(top: 3, right: 3),
                      child: Text(
                        widget.list[widget.index].bookName,
                        style: TextStyle(fontSize: 17),
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3, right: 5),
                      child: Text(
                        '作者:' + widget.list[widget.index].author,
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                    //最新章节
                    Container(
                      margin: EdgeInsets.only(top: 4, right: 5),
                      child: Text(
                        '最新章节: ' + widget.list[widget.index].lastTitle,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
//      color: Colors.yellow,
      ),
      onTap: () {
        //TODO
        Navigator.pushNamed(context, '/introPage', arguments: {
          'bookUrl': widget.list[widget.index].bookUrl,
          'currentIndex': 0,
        });
      },
    );
  }
}
