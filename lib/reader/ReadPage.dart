import 'package:flutter/material.dart';
import 'package:novel_reader/reader/ReaderMenu.dart';
import 'dart:ui' as ui show window;

import 'package:novel_reader/reader/ReaderView.dart';

class ReadPage extends StatefulWidget {
  final String name;
  final List bookList;
  final int index;
  const ReadPage({Key key, this.name, this.bookList, this.index})
      : super(key: key);
  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  bool isMenuVisible = false;
  MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
  int cIndex;
  String sectionUrl;

  @override
  void initState() {
    super.initState();
    cIndex = widget.index ?? 0;
    sectionUrl = 'http://www.xbiqige.com' +
        '/novelsearch/reader/transcode/siteid/' +
        widget.bookList[cIndex]
            .split('+')[1]
            .split('shu_')[1]
            .split('.html')[0] +
        '/';
    // print(sectionUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                left: 0,
                top: 0,
                right: 0,
                bottom: 0,
                child: Image.asset('images/read_bg.png', fit: BoxFit.cover)),
            buildPageView(),
            buildMenu(),
          ],
        ),
      ),
    );
  }

  buildMenu() {
    if (!isMenuVisible) {
      return Container();
    }
    return ReaderMenu(
      onTap: hideMenu,
      name: widget.name,
      index: cIndex,
      characterName: widget.bookList[cIndex].split('+')[0],
    );
  }

  hideMenu() {
    setState(() {
      this.isMenuVisible = false;
    });
  }

  buildPageView() {
    return GestureDetector(
      child: ReaderView(
        sectionUrl: sectionUrl,
      ),
      // child: Center(
      //   child: Text(
      //     sectionUrl,
      //     style: TextStyle(fontSize: 30.0),
      //   ),
      // ),
      onTapUp: (TapUpDetails details) {
        onTap(details.globalPosition);
      },
    );
  }

  onTap(Offset position) async {
    double xRate = position.dx / mediaQuery.size.width;
    if (xRate > 0.33 && xRate < 0.66) {
      setState(() {
        isMenuVisible = true;
      });
    } else if (xRate >= 0.66) {
      print('下一页');
    } else {
      print('上一页');
    }
  }
}
