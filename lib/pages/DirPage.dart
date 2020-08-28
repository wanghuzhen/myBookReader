import 'package:flutter/material.dart';

class DirPage extends StatefulWidget {
  final List<String> dirList;

  const DirPage({Key key, this.dirList}) : super(key: key);
  @override
  _DirPageState createState() => _DirPageState();
}

class _DirPageState extends State<DirPage> {
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('目录'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //TODO 跳转搜索到的目录项
              },
            )
          ],
        ),
        body: Stack(
          children: [
            ListView.separated(
              itemCount: widget.dirList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(widget.dirList[index].split('/')[0]),
                  onTap: () {
                    //TODO 跳转阅读页面
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  thickness: 0.4,
                  height: 0.0,
                  color: Colors.black12,
                );
              },
            ),
//显示章节数目，或者改用FlatButton
//            Align(
//              alignment: Alignment(0.0, 1.0),
//              child: Container(
//                height: 50,
//                decoration: BoxDecoration(color: Colors.white, boxShadow: [
//                  BoxShadow(
//                    color: Colors.grey,
//                    blurRadius: 3.0,
//                  )
//                ]),
//                child: Row(
//                  children: [
//                    Expanded(
//                      child: Container(
//                        margin: EdgeInsets.only(left: 16.0),
//                        child: Text(
//                          '共' + widget.dirList.length.toString() + '章',
//                          style: TextStyle(
//                            fontSize: 17.0,
//                          ),
//                        ),
//                      ),
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.end,
//                      children: [
//                        IconButton(
//                          icon: Icon(Icons.keyboard_arrow_up),
//                          onPressed: () {
//                            //TODO 置顶
//                          },
//                          splashColor: Colors.transparent,
//                          highlightColor: Colors.transparent,
//                        ),
//                        IconButton(
//                          splashColor: Colors.transparent,
//                          highlightColor: Colors.transparent,
//                          icon: Icon(Icons.keyboard_arrow_down),
//                          onPressed: () {
//                            //TODO 置底
//                          },
//                        ),
//                      ],
//                    )
//                  ],
//                ),
//              ),
//            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          onPressed: () {
            setState(() {
              showToTopBtn = !showToTopBtn;
            });
          },
          child: Icon(
            showToTopBtn ? Icons.arrow_upward : Icons.arrow_downward,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          splashColor: Colors.transparent,
          highlightElevation: 0.0,
        ),
      ),
    );
  }
}
