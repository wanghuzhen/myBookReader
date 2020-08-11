import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListLabel extends StatelessWidget {
  final String text;
  const ListLabel({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _buildListLabel(),
      onTap: (){
        Navigator.pushNamed(context,'/classify',arguments: text);
      },
    );
  }
  Widget _buildListLabel(){
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 12),
      height: 40,
      decoration: BoxDecoration(
          color: Color.fromRGBO(238, 238, 238, 50),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(fontSize: 17),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
