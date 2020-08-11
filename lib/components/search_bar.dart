import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final bool enable;
  final bool hideLeft;
  final String hint;
  final String defaultText;
  final TextEditingController controller;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() inputBoxClick;
  final void Function(String text) onSubmit;

  const SearchBar({
    Key key,
    this.enable = true,
    this.hideLeft,
    this.hint,
    this.defaultText,
    this.controller,
    this.leftButtonClick,
    this.rightButtonClick,
    this.inputBoxClick,
    this.onSubmit,
  });

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    if (widget.defaultText != null) {
      setState(() {
        widget.controller.text = widget.defaultText;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black54,
                  size: 26,
                ),
              ),
              widget.leftButtonClick),
          Expanded(flex: 1, child: _inputBox()),
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  '搜索',
                  style: TextStyle(color: Colors.black54, fontSize: 17),
                ),
              ),
              widget.rightButtonClick),
        ],
      ),
    );
  }

  _inputBox() {
    Color inputBoxColor = Color(0xffEDEDED);
    return Container(
      height: 30,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: inputBoxColor, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: <Widget>[
          Icon(Icons.search, size: 20, color: Color(0xffA9A9A9)),
          Expanded(
              flex: 1,
              child: TextField(
                controller: widget.controller,
                autofocus: false,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, -20, 5, 0),
                    border: InputBorder.none,
                    hintText: widget.hint ?? '',
                    hintStyle: TextStyle(fontSize: 15)),
                enableInteractiveSelection: false,
                onSubmitted: widget.onSubmit,
              )),
          _wrapTap(
              Icon(
                Icons.clear,
                size: 22,
                color: Colors.grey,
              ), () {
            setState(() {
              widget.controller.clear();
            });
          })
        ],
      ),
    );
  }

  _wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) callback();
      },
      child: child,
    );
  }
}
