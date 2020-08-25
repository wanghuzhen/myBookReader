import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:novel_reader/model/all_model.dart';
import 'package:novel_reader/utils/request.dart';

class IntroPage extends StatefulWidget {
  final String bookUrl;

  const IntroPage({Key key, this.bookUrl}) : super(key: key);
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  BookIntro _intro;

  @override
  void initState() {
    _fetchIntro(widget.bookUrl);
    super.initState();
  }

  _fetchIntro(String url) async {
    try {
      List<String> _list = new List();
      HttpUtils res = HttpUtils(0);
      var result = await res.getInstance().get(url);
      var document = parse(result.data.toString());
      for (int i = 0;
          i <
              document
                  .querySelector('.fulldir')
                  .querySelectorAll('div>ul>li>a')
                  .length;
          i++) {
        _list.add(document
                .querySelector('.fulldir')
                .querySelectorAll('div>ul>li>a')[i]
                .text
                .trim() +
            '/' +
            document
                .querySelector('.fulldir')
                .querySelectorAll('div>ul>li>a')[i]
                .attributes['href']);
      }
      setState(() {
        _intro = BookIntro(
          url,
          document.querySelector('.line>h1').text.trim(),
          document.querySelector('.novelinfo-r>a>img').attributes['src'],
          document
              .querySelectorAll('.novelinfo-l>ul>li')[0]
              .querySelector('a')
              .text
              .trim(),
          document
              .querySelectorAll('.novelinfo-l>ul>li')[5]
              .querySelector('a')
              .attributes['href'],
          document
              .querySelectorAll('.novelinfo-l>ul>li')[5]
              .querySelector('a')
              .text
              .trim(),
          document.querySelector('.novelintro').text.trim(),
          document.querySelectorAll('.novelinfo-l>ul>li')[4].text.trim(),
          document.querySelectorAll('.novelinfo-l>ul>li')[6].text.trim(),
          document
              .querySelector('.fulldir')
              .querySelectorAll('div>ul>li')
              .length,
          _list,
//        document.querySelector('.fulldir').querySelectorAll('div')[1].querySelectorAll('ul>li').length-1
        );
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Container(
      child: Scaffold(
        body: _intro == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: width,
                height: height,
                child: Stack(
                  children: [
                    Image.network(
                      'http://www.xbiqige.com' + _intro.bookCover,
                      fit: BoxFit.fitWidth,
                      width: width,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                    AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
//                          Navigator.of(context).pushNamedAndRemoveUntil(
//                              '/', (route) => route == null);
                        },
                      ),
                      title: Text(
                        '书籍信息',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipPath(
                        clipper: MyClipper(),
                        child: Container(
                          width: width,
                          height: 0.75 * height,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.0, -0.6),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                              'http://www.xbiqige.com' + _intro.bookCover,
                              fit: BoxFit.cover,
                              width: 128,
                              height: 176)),
                    ),
                    Align(
                      alignment: Alignment(0.0, -0.2),
                      child: Text(
                        _intro.bookName,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Align(
                      child: Container(
                        height: 140,
                        width: width,
//                        color: Colors.blue,
                        margin:
                            EdgeInsets.only(left: 24.0, right: 24.0, top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image(
                                  image: AssetImage('images/author.png'),
                                  width: 17.0,
                                  height: 17.0,
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Text('作者：' + _intro.author,
                                    style: TextStyle(fontSize: 15.0)),
                              ],
                              textBaseline: TextBaseline.alphabetic,
                            ),
                            Row(
                              children: [
                                Image(
                                  image: AssetImage('images/coming.png'),
                                  width: 17.0,
                                  height: 17.0,
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Text(_intro.coming,
                                    style: TextStyle(fontSize: 15.0)),
                              ],
                            ),
                            Row(
                              children: [
                                Image(
                                  image: AssetImage('images/last.png'),
                                  width: 17.0,
                                  height: 17.0,
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Expanded(
                                  child: Text(
                                    '最新：' + _intro.lastTitle,
                                    style: TextStyle(fontSize: 15.0),
                                    maxLines: 1,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image(
                                  image: AssetImage('images/time.png'),
                                  width: 17.0,
                                  height: 17.0,
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Text(_intro.time,
                                    style: TextStyle(fontSize: 15.0)),
                              ],
                            ),
                            Row(
                              children: [
                                Image(
                                  image: AssetImage('images/dir.png'),
                                  width: 17.0,
                                  height: 17.0,
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Expanded(
                                  child: Text(
                                      '目录：共' +
                                          _intro.characterNum.toString() +
                                          '章',
                                      style: TextStyle(fontSize: 15.0)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    //TODO
                                    Navigator.pushNamed(
                                      context,
                                      '/dirPage',
                                      arguments: _intro.dirList,
                                    );
                                  },
                                  child: Text(
                                    '查看目录',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 15.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.0, 0.45),
                      child: Container(
                        height: 140,
                        width: width,
                        margin:
                            EdgeInsets.only(left: 24.0, right: 24.0, top: 30),
                        child: SingleChildScrollView(
                          child: Text(
                            _intro.intro,
                            style: TextStyle(fontSize: 15.0),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.0, 1.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              child: Text(
                                '加入',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                              onPressed: () {
                                //TODO
                              },
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              child: Text(
                                '阅读',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                              onPressed: () {
                                //TODO
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  //获取裁剪范围
  @override
  Path getClip(Size size) {
    //左上角为(0,0)
    var path = Path();
    path.moveTo(0.0, 60.0); //起始点
    var firstControlPoint = Offset(size.width / 2, 0.0);
    var firstEndPoint = Offset(size.width, 60.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, 60.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  //是否重新裁剪
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
