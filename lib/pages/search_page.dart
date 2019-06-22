import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  _appBar(context)
    );
  }
  
}


  Widget _appBar(BuildContext context) {

    return  SearchAppBarWidget(normalSearch: false);
             
  }

  