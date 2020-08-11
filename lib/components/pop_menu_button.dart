//主页右上角弹出式菜单按钮
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class PopMenuButtonDemo extends StatefulWidget {
  @override
  _PopMenuButtonDemoState createState() => _PopMenuButtonDemoState();
}

class _PopMenuButtonDemoState extends State<PopMenuButtonDemo> {
  List<String> _list = ['添加 添加本地', '网址 添加网址', '缓存 一键缓存', '布局 书架布局'];

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: Offset(0.0, 100),
      itemBuilder: (BuildContext context) =>
          List.generate(_list.length, (index) {
        String iconStr = _list[index].split(' ')[0];
        String textStr = _list[index].split(' ')[1];
        return PopupMenuItem(
            value: index,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Image(
                  image: AssetImage('images/' + iconStr + '.png'),
                  width: 20,
                  height: 20,
                ),
                new Text(textStr),
              ],
            ));
      }),
//    itemBuilder: (BuildContext context){
//      return _list.map((item) {
//        String iconStr = item.split(' ')[0];
//        String textStr = item.split(' ')[1];
//        int index =_list.indexOf(item);
//        return PopupMenuItem(
//            value: index,
//            child: new Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                new Image(
//                  image: AssetImage('images/' + iconStr + '.png'),
//                  width: 20,
//                  height: 20,
//                ),
//                new Text(textStr),
//              ],
//            ));
//      }).toList();
//    },
      onSelected: (int action) {
        // 点击选项的时候
        switch (action) {
          case 0:
            Toast.show('暂无操作_1', context,
                backgroundRadius: 5.0, backgroundColor: Colors.black45);
            break;
          case 1:
            Toast.show('暂无操作_2', context,
                backgroundRadius: 5.0, backgroundColor: Colors.black45);
            break;
          case 2:
            Toast.show('暂无操作_3', context,
                backgroundRadius: 5.0, backgroundColor: Colors.black45);
            break;
          case 3:
            Toast.show('暂无操作_4', context,
                backgroundRadius: 5.0, backgroundColor: Colors.black45);
            break;
        }
      },
    );
  }
}
