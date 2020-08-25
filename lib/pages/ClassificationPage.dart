import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:novel_reader/components/book_item.dart';
import 'package:novel_reader/utils/request.dart';
import 'package:novel_reader/model/all_model.dart';
import 'package:novel_reader/components/LoadingView.dart';

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
  ScrollController _scrollController;
  int _classificationPage;

  @override
  void initState() {
    super.initState();
    __fetchClassifyList();
    _classificationPage = 2;
    _scrollController = ScrollController()
      ..addListener(() {
        //判断是否滑到底端，进行上拉加载更多
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _loadMore();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future _loadMore() async {
    int index;
    switch (widget.arguments) {
      case '新笔趣阁':
        index = 0;
        try {
          HttpUtils res = HttpUtils(index);
          String _urlPath;
          List<String> _temp = _classifyList[_selectedClassifyId].classifyUrl.split('.');
          _urlPath = _temp[0]+'/'+(_classificationPage++).toString()+'.'+_temp[1];
          var result =
              await res.getInstance().get(_urlPath);
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
            _novelList.addAll(temp);
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

//  _buildBookClassifyList() {
//    return Expanded(
//      flex: 8,
//      child: _novelList.length == 0
//          ? Center(
//              child: CircularProgressIndicator(),
//            )
//          : ListView(
//              children: List.generate(_novelList.length, (index) {
//                return _buildBookClassifyItem(index);
//              }),
//            ),
//    );
//  }
  //TODO--上拉刷新
  //添加上拉加载更多
  _buildBookClassifyList() {
    return Expanded(
      flex: 8,
      child: _novelList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: _novelList.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == _novelList.length) {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: LoadingView(),
                    ),
                  );
                }
                return BookItem(index: index,netApiId: 0,list: _novelList,);
//                return _buildBookClassifyItem(index);
              },
            ),
    );
  }
}
