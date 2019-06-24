import 'package:flutter/material.dart';


//底部加载更多进度条组件
class BottomLoadingContainer extends StatelessWidget {
  final bool isLoadMore;
  final int bgColor;

  const BottomLoadingContainer({
      @required this.isLoadMore,
      this.bgColor = 0xFFDDDDDD,
  });

  @override
  Widget build(BuildContext context) {
    return isLoadMore ?  _bottomloadMore : Text('');
  }

  Widget get _bottomloadMore {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Color(bgColor)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 12,
            width: 12,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.cyan),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 10),
            child: Text('加载中...',style: TextStyle(color: Colors.black45),),
          )
        ],
      ),
    );
  }
}
