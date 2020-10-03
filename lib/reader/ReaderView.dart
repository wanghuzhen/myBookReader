import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_reader/components/LoadingView.dart';
import 'package:novel_reader/utils/request.dart';
import 'package:html/parser.dart';

class ReaderView extends StatefulWidget {
  final String sectionUrl;

  const ReaderView({Key key, this.sectionUrl}) : super(key: key);
  @override
  _ReaderViewState createState() => _ReaderViewState();
}

class _ReaderViewState extends State<ReaderView> {
  String content;

  @override
  void initState() {
    super.initState();
    _fetchContent(widget.sectionUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 56.0, 4.0, 10.0),
      child: SingleChildScrollView(
        child: content != null
            ? Text(
                content,
                style: TextStyle(fontSize: 18.0),
              )
            : Align(
                child: LoadingView(),
              ),
      ),
    );
  }

  // http://www.xbiqige.com/novelsearch/reader/transcode/siteid/87697/1/
  Future _fetchContent(String sectionUrl) async {
    // print(sectionUrl);
    try {
      HttpUtils res = HttpUtils(0);
      var result = await res.getInstance().get(sectionUrl);
      var document = parse(result.data.toString());
      var temp = document.querySelector('body').innerHtml.split('"')[3];
      setState(() {
        content = unicodeToString(temp);
      });
    } catch (e) {
      setState(() {
        content = e.toString();
      });
    }
  }

  unicodeToString(String unicode) {
    String str = '';
    List<int> list = [];
    unicode = unicode.replaceAll('<br>\\n<br>\\n', '\n');
    var i = unicode.indexOf('\\u');
    while (i != -1) {
      list.add(i);
      i = unicode.indexOf('\\u', i + '\\u'.length);
    }
    // print(list.last.toString() + ' ' + unicode.length.toString());
    for (int i = 0; i < list.length; i++) {
      String temp = unicode.substring(list[i] + 2, list[i] + 6);
      str += String.fromCharCode(_hexToInt(temp));
      if (i < list.length - 1 && list[i + 1] - list[i] > 6) {
        str += unicode.substring(list[i] + 6, list[i + 1]);
      }
      if (i == list.length - 1 && list[i] + 6 < unicode.length) {
        str += unicode.substring(list[i] + 6);
      }
    }
    // str.replaceAll('<br>\\n<br>\\n', '');
    return str;
  }

  int _hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }
}
