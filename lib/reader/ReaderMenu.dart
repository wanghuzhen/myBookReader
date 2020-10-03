import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui show window;

import 'package:toast/toast.dart';

class ReaderMenu extends StatefulWidget {
  final VoidCallback onTap;
  final String name;
  final int index;
  final String characterName;
  const ReaderMenu(
      {Key key, this.onTap, this.name, this.index, this.characterName})
      : super(key: key);

  @override
  _ReaderMenuState createState() => _ReaderMenuState();
}

class _ReaderMenuState extends State<ReaderMenu>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);

  @override
  initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animation.addListener(() {
      setState(() {});
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTapDown: (_) {
              hide();
            },
            child: Container(color: Colors.transparent),
          ),
          buildTopView(context),
          buildBottomView(),
        ],
      ),
    );
  }

  hide() {
    animationController.reverse();
    Timer(Duration(milliseconds: 200), () {
      this.widget.onTap();
    });
  }

  buildTopView(BuildContext context) {
    return Positioned(
      top: -(mediaQuery.padding.top + kToolbarHeight) * (1 - animation.value),
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 8)]),
        height: mediaQuery.padding.top + kToolbarHeight,
        padding: EdgeInsets.fromLTRB(5, mediaQuery.padding.top, 5, 0),
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('images/pub_back_gray.png'),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  widget.name,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              width: 44,
              child: Image.asset('images/read_icon_more.png'),
            ),
          ],
        ),
      ),
    );
  }

  buildBottomView() {
    return Positioned(
      bottom: -(mediaQuery.padding.bottom + 110) * (1 - animation.value),
      left: 0,
      right: 0,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color(0xFFF5F5F5), boxShadow: [
              BoxShadow(color: Color(0x22000000), blurRadius: 8)
            ]),
            padding: EdgeInsets.only(bottom: mediaQuery.padding.bottom),
            child: Column(
              children: <Widget>[
                buildProgressView(),
                buildBottomMenus(),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildBottomMenus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        buildBottomItem('目录', 'images/read_icon_catalog.png'),
        buildBottomItem('亮度', 'images/read_icon_brightness.png'),
        buildBottomItem('字体', 'images/read_icon_font.png'),
        buildBottomItem('设置', 'images/read_icon_setting.png'),
      ],
    );
  }

  buildBottomItem(String title, String icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: <Widget>[
          Image.asset(icon),
          SizedBox(height: 5),
          Text(title,
              style: TextStyle(
                  fontSize: 12 / mediaQuery.textScaleFactor,
                  color: Color(0xFF333333))),
        ],
      ),
    );
  }

  buildProgressView() {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if(widget.index==0){
                Toast.show('当前已经是第一章', context,gravity: Toast.CENTER);
              }
              else{

              }
            },
            child: Container(
              padding: EdgeInsets.all(20),
              child: Image.asset('images/read_icon_chapter_previous.png'),
            ),
          ),
          Expanded(
              child: Text(
            widget.characterName,
            style: TextStyle(fontSize: 19),
                textAlign: TextAlign.center,
          )),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(20),
              child: Image.asset('images/read_icon_chapter_next.png'),
            ),
          )
        ],
      ),
    );
  }
}
