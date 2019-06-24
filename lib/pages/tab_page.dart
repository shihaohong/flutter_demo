import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/tab/comment_page.dart';
import 'package:flutter_demo/pages/tab/photo_wall_page.dart';

class TabPage extends StatefulWidget {
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  TabController _controller;
  List<String> tabs = ['照片墙','评论'];

  @override
  void initState() {
     _controller = TabController(length: tabs.length, vsync: this); //fix tab label 空白问题
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            child: TabBar(
              controller: _controller,
            labelColor: Colors.black,
            tabs: tabs.map<Tab>((String val) => Tab(text: val))
              .toList()),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: tabs.map((String val) {
                if (val == '照片墙'){
                  return PhotoWall();
                }
                return CommentPage();
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}