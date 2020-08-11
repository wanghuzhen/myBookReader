import 'package:flutter/material.dart';
import 'book_for_find.dart';

class FindAndRecommend extends StatefulWidget {
  @override
  _FindAndRecommendState createState() => _FindAndRecommendState();
}

class _FindAndRecommendState extends State<FindAndRecommend> {
  //留着看看能不能实现个自定义Panel来实现这个界面
  Map<String, List> _bookSourceList = {'新笔趣阁': [], 'QQ阅读': [], '起点读书': []};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        children: List.generate(_bookSourceList.length, (index) {
          return ListLabel(
            text: _bookSourceList.keys.toList()[index],
          );
        }),
      ),
    );
  }
}
