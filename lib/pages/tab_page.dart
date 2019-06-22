import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/tab/comment_page.dart';
import 'package:flutter_demo/pages/tab/photo_wall_page.dart';

class TabPage extends StatefulWidget {
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  TabController _controller;
  List<String> tabs = ['照片墙','评论','好货','论坛','聊天','等等'];
 
  @override
  void initState() {
     _controller = TabController(length: 0, vsync: this);
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
            color: Colors.white,
            padding: EdgeInsets.only(top: 20),
            child: TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: Color(0xff1fcfbb), width: 3),
                    insets: EdgeInsets.only(bottom: 10)),
                tabs: tabs.map<Tab>((String val) {
                  return Tab(
                    text: val,
                  );
                }).toList()),
          ),
          Flexible(
            child: TabBarView(
                controller: _controller,
                children: tabs.map((String val) {
                  if(val=='照片墙'){
                    return PhotoWall();
                  }
                  if(val=='评论'){
                    return CommentPage();
                  }
                  return  Text(val);
                }).toList()),
          )
        ],
      ),
    );
  }


}