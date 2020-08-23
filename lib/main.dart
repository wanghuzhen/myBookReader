import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:novel_reader/pages/ClassificationPage.dart';
import 'package:novel_reader/pages/HomePage.dart';
import 'package:novel_reader/pages/SearchPage_usage.dart';
import 'package:novel_reader/pages/SearchResultPage.dart';

void main() {
  if (Platform.isAndroid) {
    // 这一步设置状态栏颜色为透明
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
  }
  runApp(Novel());
}

class Novel extends StatelessWidget {
  final Map<String, WidgetBuilder> _routes = {
    '/': (BuildContext context) => HomePage(),
    '/search': (BuildContext context) => SearchPage(),
    '/classify': (BuildContext context, {arguments}) => ClassificationPage(
          arguments: arguments,
        ),
    '/searchResult': (BuildContext context, {arguments}) => SearchResultPage(
          searchName: arguments,
        ),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '阅读',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        final String name = settings.name;
        final Function pageBuilder = _routes[name];
        if (pageBuilder != null) {
          if (settings.arguments != null) {
            // 如果透传了参数
            return MaterialPageRoute(
                builder: (context) =>
                    pageBuilder(context, arguments: settings.arguments));
          } else {
            // 没有透传参数
            return MaterialPageRoute(
                builder: (context) => pageBuilder(context));
          }
        }
        return MaterialPageRoute(builder: (context) => HomePage());
      },
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
    );
  }
}
