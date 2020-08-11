//主页左上角抽屉
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            //Stack里的图片布局仅仅占一部分
            child: Image.asset(
              'images/header_pic.jpg',
              fit: BoxFit.contain,
            )
          ),
          Divider(
            color: Colors.black45,
            thickness: 0.6,
          ),
          //TODO--加入书源
//          ListTile(
//            title: Text('书源管理'),
//            leading: Icon(Icons.menu),
//            onTap: () {
//              Navigator.pop(context);
//            },
//          ),
//          Divider(
//            color: Colors.black12,
//            thickness: 0.6,
//          ),
          ListTile(
            title: Text('主题'),
            leading: Icon(Icons.color_lens),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(
            color: Colors.black45,
            thickness: 0.6,
          ),          ListTile(
            title: Text('设置'),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
