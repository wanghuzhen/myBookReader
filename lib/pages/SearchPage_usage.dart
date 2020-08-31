//第二种SearchPage实现方式，搜索框长，自定义AppBar
//需要获取手机的刘海、状态栏，可能会出现不适配情况

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:novel_reader/components/search_bar.dart';
import 'package:toast/toast.dart';
import 'package:novel_reader/model/all_model.dart';
import 'package:novel_reader/utils/request.dart';
import 'package:novel_reader/utils/save_data.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode verifyNode = FocusNode();
  List<HotBook> _hotList = [];
  List<String> _historyList = [];

  @override
  void initState() {
    super.initState();
    _fetchHistoryList();
    _fetchHotList();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    verifyNode.dispose();
  }

  Future _fetchHotList() async {
    try {
      HttpUtils res = HttpUtils(0);
      var result = await res.getInstance().get('');
      var document = parse(result.data.toString());
      var hostList =
          document.querySelector('.rightlist').querySelectorAll('li');
      List<HotBook> temp = [];
      for (int i = 0; i < hostList.length; i++) {
        HotBook item = HotBook(
            hostList[i].querySelectorAll('a')[1].attributes['href'],
            hostList[i].querySelectorAll('a')[1].attributes['title']);
        temp.add(item);
      }
      setState(() {
        _hotList = temp;
      });
    } catch (e) {
      print(e);
    }
  }

  Future _fetchHistoryList() async {
    SharedPreferencesDataUtils sp = SharedPreferencesDataUtils();
    await sp.getUserInfo('HISTORY_BOOK_LIST').then((value) {
      if (value != null) {
        setState(() {
          _historyList.addAll(value);
        });
      }
    });
  }

  _buildHotBookView() {
    List<Widget> content = [];
    content.add(NavTitle(
      title: '热门搜索',
      leftMarginValue: 16.0,
      topMarginValue: 10.0,
    ));
    if (_hotList.length > 0) {
      content.add(HotBookCard(
        list: _hotList,
      ));
    }
    return Container(
      child: Column(
        children: content,
      ),
    );
  }

  _buildHistoryBookView() {
    List<Widget> content = [];
    Widget _buildHistoryAndClear() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavTitle(
            title: '历史记录',
            leftMarginValue: 16.0,
            topMarginValue: 10.0,
          ),
          GestureDetector(
            child: NavTitle(
              title: '清除',
              rightMarginValue: 16.0,
              topMarginValue: 10.0,
            ),
            onTap: () {
              setState(() {
                //TODO--加上清除延时3s，这段时间内可以回撤
                _historyList.clear();
                SharedPreferencesDataUtils sp = SharedPreferencesDataUtils();
                sp.setUserInfo('HISTORY_BOOK_LIST', _historyList);
              });
            },
          )
        ],
      );
    }

    content.add(_buildHistoryAndClear());
    if (_historyList.length > 0) {
      content.add(HistoryBookCard(
        list: _historyList,
      ));
    }
    return Container(
      child: Column(
        children: content,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [_appBar(), _buildHotBookView(), _buildHistoryBookView()],
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
          textController: _controller,
          verifyNode: verifyNode,
          leftButtonClick: () {
            Navigator.pop(context, '/');
          },
          rightButtonClick: _rightButtonClick,
          onSubmit: _onSubmit,
        ),
      ),
    );
  }

  _rightButtonClick() {
    if (_controller.text == '') {
      Toast.show('搜索内容不可为空', context,
          backgroundRadius: 5.0, backgroundColor: Colors.black45);
    } else {
      if (!_historyList.contains(_controller.text)) {
        setState(() {
          _historyList.add(_controller.text);
          SharedPreferencesDataUtils sp = SharedPreferencesDataUtils();
          sp.setUserInfo('HISTORY_BOOK_LIST', _historyList);
        });
      }
      verifyNode.unfocus();
      Navigator.pushNamed(context, '/searchResult',
          arguments: _controller.text);
    }
  }

  _onSubmit(String text) {
    if (text != '') {
      if (!_historyList.contains(text)) {
        setState(() {
          _historyList.add(text);
          SharedPreferencesDataUtils sp = SharedPreferencesDataUtils();
          sp.setUserInfo('HISTORY_BOOK_LIST', _historyList);
        });
      }
      Navigator.pushNamed(context, '/searchResult', arguments: text);
    }
  }
}

class NavTitle extends StatelessWidget {
  final String title;
  final double leftMarginValue;
  final double topMarginValue;
  final double rightMarginValue;
  final double bottomMarginValue;

  NavTitle(
      {this.title,
      this.leftMarginValue,
      this.topMarginValue,
      this.rightMarginValue,
      this.bottomMarginValue});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
            left: leftMarginValue ?? 0.0,
            top: topMarginValue ?? 0.0,
            right: rightMarginValue ?? 0.0,
            bottom: bottomMarginValue ?? 0.0),
        child: Text(title,
            style: TextStyle(
              color: Color.fromRGBO(80, 80, 80, 100),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}

class HotBookCard extends StatelessWidget {
  final List list;

  const HotBookCard({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 15.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: -8.0,
        children: list.map((item) {
          return ActionChip(
            padding: EdgeInsets.all(0.0),
            elevation: 4.0,
            label: Text(
              item.bookTitle,
              style: TextStyle(fontSize: 14),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/introPage',
                arguments: {
                  'bookUrl': item.bookUrl,
                  'currentIndex': 0,
                },
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class HistoryBookCard extends StatelessWidget {
  final List list;

  const HistoryBookCard({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 15.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: -8.0,
        children: list.map((item) {
          return ActionChip(
            padding: EdgeInsets.all(0.0),
            elevation: 4.0,
            label: Text(
              item,
              style: TextStyle(fontSize: 14),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () {
              Navigator.pushNamed(context, '/searchResult', arguments: item);
            },
          );
        }).toList(),
      ),
    );
  }
}
