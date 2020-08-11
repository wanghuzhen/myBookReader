import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:novel_reader/utils/request.dart';
import 'package:novel_reader/model/all_model.dart';
import 'package:toast/toast.dart';

class ClassificationPage extends StatefulWidget {
  final String arguments;

  const ClassificationPage({Key key, this.arguments}) : super(key: key);
  @override
  _ClassificationPageState createState() => _ClassificationPageState();
}

class _ClassificationPageState extends State<ClassificationPage> {
  List<Classification> _classifyList = [];
  List<BookClassifyItem> _novelList = [];
  int _selectedClassifyId = 0;
  @override
  void initState() {
    super.initState();
    __fetchClassifyList();
  }

  @override
  Widget build(BuildContext context) {
    String value = widget.arguments;
    return Container(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 2, left: 80, right: 10),
                  child: Image(
                    image: AssetImage('images/' + value + '.png'),
                    width: 20,
                    height: 20,
                  ),
                ),
                Text(value)
              ],
            )),
        body: Container(
          child: Row(
            children: [
              _buildClassifyList(),
              _buildBookClassifyList(),
            ],
          ),
        ),
      ),
    );
  }

  Future __fetchClassifyList() async {
    int index;
    switch (widget.arguments) {
      case '新笔趣阁':
        index = 0;
        try {
          HttpUtils res = HttpUtils(index);
          var result = await res.getInstance().get('/');
          var document = parse(result.data.toString());
//          print(result.data.toString().length);
          var content = document.querySelector('.body').querySelectorAll('a');
          List<Classification> temp = [];
          for (int i = 0; i < content.length; i++) {
            Classification item = Classification(
                content[i].attributes['href'], content[i].attributes['title']);
//            print(item.classification+item.classifyUrl);
            temp.add(item);
          }
          setState(() {
            _classifyList.clear();
            _classifyList = temp;
          });
          _fetchBookClassificationList(_selectedClassifyId);
        } catch (e) {
          print(e);
        }
        break;
      case 'QQ阅读':
        index = 1;
//        HttpUtils res = HttpUtils(index);

        break;
      case '起点读书':
        index = 2;
//        HttpUtils res = HttpUtils(index);

        break;
    }
  }

  Future _fetchBookClassificationList(int selectId) async {
    int index;
    switch (widget.arguments) {
      case '新笔趣阁':
        index = 0;
        try {
          HttpUtils res = HttpUtils(index);
          var result =
              await res.getInstance().get(_classifyList[selectId].classifyUrl);
          var document = parse(result.data.toString());
          var bookList =
              document.querySelector('.librarylist').querySelectorAll('li');
//          print(bookList.length);
          List<BookClassifyItem> temp = [];
          for (int i = 0; i < bookList.length; i++) {
            BookClassifyItem item = BookClassifyItem(
              bookList[i].querySelector('.pt-ll-l>a').attributes['href'],
              bookList[i].querySelector('.pt-ll-l>a').attributes['title'],
              bookList[i].querySelector('.pt-ll-l>a>img').attributes['src'],
              bookList[i]
                  .querySelectorAll('.pt-ll-r>p')[0]
                  .querySelectorAll('span')[1]
                  .querySelector('a')
                  .text
                  .trim(),
              bookList[i]
                  .querySelectorAll('.pt-ll-r>p')[0]
                  .querySelectorAll('span')[1]
                  .querySelector('a')
                  .attributes['href'],
              bookList[i].querySelectorAll('.pt-ll-r>p')[1].text.trim(),
              bookList[i]
                  .querySelectorAll('.pt-ll-r>p')[2]
                  .querySelector('a')
                  .attributes['href'],
              bookList[i]
                  .querySelectorAll('.pt-ll-r>p')[2]
                  .querySelector('a')
                  .text
                  .trim(),
            );
            temp.add(item);
          }
//          print('结果' + temp[0].lastUrl);
          setState(() {
            _novelList = temp;
          });
        } catch (e) {
          print(e);
        }
        break;
      case 'QQ阅读':
        index = 1;
//        HttpUtils res = HttpUtils(index);

        break;
      case '起点读书':
        index = 2;
//        HttpUtils res = HttpUtils(index);

        break;
    }
  }

  _buildClassifyList() {
    return Expanded(
        flex: 3,
        child: Container(
          width: 110,
          color: Color.fromRGBO(240, 240, 240, 100),
          child: ListView(
            children: List.generate(_classifyList.length, (index) {
              return _buildClassifyItem(
                  item: _classifyList[index].classification, index: index);
            }),
          ),
        ));
  }

  _buildClassifyItem({String item, int index}) {
    bool _isCurrent = _selectedClassifyId == index;
    return Container(
      height: 54,
      color: _isCurrent ? Colors.white54 : Color.fromRGBO(240, 240, 240, 100),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedClassifyId = index;
          });
          if (!_isCurrent) {
            _fetchBookClassificationList(index);
          }
        },
        child: Center(
          child: Text(
            item,
            style: _isCurrent
                ? TextStyle(
                    color: Color.fromRGBO(44, 131, 245, 1.0), fontSize: 19)
                : TextStyle(
                    color: Color.fromRGBO(128, 128, 128, 100), fontSize: 17),
          ),
        ),
      ),
    );
  }

  _buildBookClassifyList() {
    return Expanded(
      flex: 8,
      child: ListView(
        children: List.generate(_novelList.length, (index) {
          return _buildBookClassifyItem(index);
        }),
      ),
    );
  }
//TODO--上拉刷新
  _buildBookClassifyItem(int index) {
    int netApiId;
    switch (widget.arguments) {
      case '新笔趣阁':
        netApiId = 0;
        break;
      case 'QQ阅读':
        netApiId = 1;
        break;
      case '起点读书':
        netApiId =2;
        break;
    }
    List<String> api=[
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
          color: Color(0xffcfd2ce),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0))),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(api[netApiId]+_novelList[index].bookCover,
                        fit: BoxFit.cover, width: 92, height: 120)),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //书名/作者名
                    Container(
                      margin: EdgeInsets.only(top: 3, right: 3),
                      child: Text(
                        _novelList[index].bookName,
                        style: TextStyle(fontSize: 17),
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3, right: 5),
                      child: Text(
                        '作者:' + _novelList[index].author,
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                    //最新章节
                    Container(
                      margin: EdgeInsets.only(top: 4, right: 5),
                      child: Text(
                        '最新章节: ' + _novelList[index].lastTitle,
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
        Toast.show('尚未完成', context);
      },
    );
  }
}
