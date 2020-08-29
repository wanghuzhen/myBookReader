import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DirPage extends StatefulWidget {
  final Map catalogueList;

  const DirPage({Key key, this.catalogueList}) : super(key: key);
  @override
  _DirPageState createState() => _DirPageState();
}

class _DirPageState extends State<DirPage> {
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
  bool showSearchField = false;
  ScrollController _scrollController = new ScrollController();
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  double itemHeight = 56.0;

  @override
  void initState() {
    var widgetsBinding = WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((callback) {
      scrollTo();
    });
    super.initState();
    //监听滚动事件，打印滚动位置
    _scrollController.addListener(() {
      if (_scrollController.offset < itemHeight * 8 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_scrollController.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: showSearchField
              ? Container(
                  height: 40,
                  child: TextField(
                    focusNode: _focusNode,
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _controller.clear();
                          });
                        },
                      ),
                      contentPadding: EdgeInsets.only(left: 10.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                      hintText: '请输入章节名称',
                    ),
                    controller: _controller,
                    onSubmitted: _onSubmit,
                  ),
                )
              : Text('目录'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  showSearchField = !showSearchField;
                });
              },
            )
          ],
        ),
        body: ListView.builder(
          itemExtent: itemHeight,
          itemCount: widget.catalogueList['catalogue'].length,
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                      widget.catalogueList['catalogue'][index].split('/')[0]),
                  onTap: () {
                    //TODO 跳转阅读页面
                  },
                ),
                Divider(
                  thickness: 0.4,
                  height: 0.0,
                  color: Colors.black12,
                )
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 4.0,
          onPressed: topOrBottom,
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

  toSearchItem(int index) async {
    if (_scrollController.hasClients) {
      await _scrollController.animateTo(index * itemHeight,
          duration: Duration(microseconds: 1), curve: Curves.ease);
    }
  }

  topOrBottom() async {
    if (_scrollController.hasClients) {
      int temp =
          showToTopBtn ? 0 : widget.catalogueList['catalogue'].length - 8;
      await _scrollController.animateTo(temp * itemHeight,
          duration: Duration(microseconds: 1), curve: Curves.ease);
    }
  }

  void _onSubmit(String value) {
    if (value == '') {
      Toast.show('内容不可为空', context, gravity: Toast.CENTER);
    } else {
      int index = -1;
      for (int i = 0; i < widget.catalogueList['catalogue'].length; i++) {
        if (widget.catalogueList['catalogue'][i].indexOf(value) != -1) {
          index = i;
          break;
        }
      }
      if (index != -1) {
        setState(() {
          showSearchField = !showSearchField;
        });
        toSearchItem(index);
      } else {
        Toast.show('没有此章节', context, gravity: Toast.CENTER);
      }
    }
  }

  //滚动到当前阅读位置
  scrollTo() async {
    if (_scrollController.hasClients) {
      await _scrollController.animateTo(
          widget.catalogueList['currentIndex'] * itemHeight,
          duration: Duration(microseconds: 1),
          curve: Curves.ease);
    }
  }
}

/*  留存，这个样式用Stack实现，在目录最底端显示章节数目、和置顶置底两个按钮
用法：直接替换上面body部分，然后注释掉floatingActionButton
Stack(
          children: [
            ListView.builder(
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
            Align(
              alignment: Alignment(0.0, 1.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                  )
                ]),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: Text(
                          '共' + widget.dirList.length.toString() + '章',
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.keyboard_arrow_up),
                          onPressed: () {
                            //TODO 置顶
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: Icon(Icons.keyboard_arrow_down),
                          onPressed: () {
                            //TODO 置底
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )

  //search按钮的onpressed操作
  //TODO 跳转搜索到的目录项
                if (_controller.text == '') {
                  Toast.show('内容不可为空', context, gravity: Toast.CENTER);
                } else {
                  int index = -1;
                  for (int i = 0; i < widget.dirList.length; i++) {
                    if (widget.dirList[i].indexOf(_controller.text) != -1) {
                      index = i;
                      break;
                    }
                  }
                  if (index != -1) {
                    _focusNode.unfocus();
                    setState(() {
                      showSearchField = !showSearchField;
                    });
                    toSearchItem(index);
                  } else {
                    Toast.show('没有此章节', context, gravity: Toast.CENTER);
                  }
                }
 */
