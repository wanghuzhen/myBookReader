import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:novel_reader/components/book_shelf.dart';
import 'package:novel_reader/components/find_recommend.dart';
import 'package:novel_reader/components/my_drawer.dart';
import 'package:novel_reader/components/pop_menu_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: AppBar(
            elevation: 3.0,
            title: Text('阅读'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).pushNamed('/search');
                },
              ),
              PopMenuButtonDemo()
            ],
            bottom: TabBar(
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: <Widget>[
                Tab(
                  text: '所有书籍',
                ),
                Tab(
                  text: '发现&推荐',
                )
              ],
            ),
          ),
          body: DoubleBackToCloseApp(
            snackBar: SnackBar(
              content: Text('再点一次退出程序'),
            ),
            child: TabBarView(
              children: <Widget>[
                BookShelfCmp(),
                FindAndRecommend(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
