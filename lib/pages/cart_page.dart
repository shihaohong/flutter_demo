import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartPage extends StatelessWidget {
  String data = "人生啊人生";
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();

    // return Container(
    //   child: Center(
    //     child: Text("购物车"),
    //   )
    // );

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("CopyAndPast"),
      ),
      body:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Text(data),
              onLongPress: (){
                Clipboard.setData(ClipboardData(text:data));
                key.currentState.showSnackBar(SnackBar(content:Text('已经复制到剪切板')));
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "黏贴这里"
              ),
            )
          ],
        ),
      )
    );
  }
}