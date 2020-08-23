import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:novel_reader/model/all_model.dart';
import 'package:novel_reader/utils/request.dart';

class SearchResultPage extends StatefulWidget {
  final String searchName;

  const SearchResultPage({Key key, this.searchName}) : super(key: key);
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  List<BookSearchItem> _books = new List();

  @override
  void initState() {
    super.initState();
    _fetchBookList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.only(right: 56.0),
            alignment: Alignment.center,
            child: Text(widget.searchName),
          ),
        ),
        body: _books.length == 0
            ? Center(
                child: Text("正在加载数据..."),
              )
            : Container(
                margin: EdgeInsets.all(10),
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return _buildResult(context, _books[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        thickness: 1.0,
                        height: 0.0,
                        color: Colors.black54,
                      );
                    },
                    itemCount: _books.length),
              ),
      ),
    );
  }

  Future _fetchBookList() async {
    try {
      HttpUtils res = HttpUtils(0);
      var result = await res.getInstance().get(
          '/search.html?searchtype=novelname&searchkey=${widget.searchName}');
      var document = parse(result.data.toString());
      var content = document.querySelectorAll(".librarylist>li");
      List<BookSearchItem> temp = [];
      for (int i = 0; i < content.length; i++) {
        BookSearchItem item = new BookSearchItem(
          //书名
          content[i].querySelector('.pt-ll-l>a').attributes['title'],
//          //图书地址
          content[i].querySelector('.pt-ll-l>a').attributes['href'],
//          //作者
          content[i]
              .querySelectorAll('.pt-ll-r>p>span')[1]
              .querySelector('a')
              .attributes['title']
              .split(' ')[0],
//          //最新章节url
          content[i]
              .querySelectorAll('.pt-ll-r>p')[2]
              .querySelector('a')
              .attributes['href'],
//          //最新章节标题
          content[i]
              .querySelectorAll('.pt-ll-r>p')[2]
              .querySelector('a')
              .text
              .trim(),
//          //文章类型
          content[i]
              .querySelectorAll('.pt-ll-r>p>span')[2]
              .querySelector('a')
              .text
              .trim(),
//          //图书封面
          content[i].querySelector('.pt-ll-l>a>img').attributes['src'],
//          //更新时间
          content[i].querySelectorAll('.pt-ll-r>p')[2].text.trim(),
        );
//        print('搜索结果：' + item.time);
        temp.add(item);
      }
      setState(() {
        _books.addAll(temp);
      });
    } catch (e) {
      print('获取书籍列表出错' + e.toString());
    }
  }

  Widget _buildResult(BuildContext context, BookSearchItem book) {
    return Container(
        margin: EdgeInsets.all(2.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            //TODO
          },
          child: Container(
            child: Container(
                height: 140,
                margin: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 120,
                      width: 90,
                      child: Image.network(
                          'http://www.xbiqige.com' + book.bookCover,
                          fit: BoxFit.cover,
                          width: 100,
                          height: 120),
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(left: 20,top: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Text(
                              '作品：' + book.bookName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 18.0),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 0),
                                child: Text(
                                  "类型：" + book.type,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                      fontSize: 14.0),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  '作者：' + book.author,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                      fontSize: 14.0),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              '最新章节：'+book.lastTitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 16.0),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              '更新时间：('+book.time.split('(')[1],
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontSize: 16.0),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                )),
          ),
        ));
  }
}
