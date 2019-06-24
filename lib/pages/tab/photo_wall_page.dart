import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_demo/widget/loading_container.dart';

class PhotoWall extends StatefulWidget {
  _PhotoWallState createState() => _PhotoWallState();
}

class _PhotoWallState extends State<PhotoWall> with AutomaticKeepAliveClientMixin {
  bool _loading = true; //页面加载状态
  int _count = 12; //一页12个
  bool _loadMore = false; //上拉加载更多

  //Flutter的ListView中有一个ScrollController属性，通过监听这个滑动来实现加载更多
  ScrollController _scrollController = new ScrollController();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    hideScreen();

    //监听滑动到底部时，加载更多
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
          setState(() {
           _loadMore =true;
          });
          _getMoreData();
      }
    });

    super.initState();
  }

  //显示加载进度条
  Future<void> hideScreen() async {
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
       _loading = false;
      });
    });
  }

  //下拉刷新
  Future<Null> _handleRefresh() async {
    // 延迟2秒后添加新数据， 模拟网络加载
    await Future.delayed(Duration(seconds: 2), () {
       return null;
    });

  }

  // 上拉加载更多
  Future _getMoreData() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _count += 12;
        _loadMore = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingContainer(
        isLoading: _loading,
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: _showPic,
        ),
      ),
    );
  }


  Widget get _showPic {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: StaggeredGridView.countBuilder(
        controller: _scrollController,
        crossAxisCount: 4,
        itemCount: _count,
        itemBuilder: (BuildContext context, int index) => Container(
            color: Colors.green,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('$index'),
              ),
            )
        ),
        staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 2 : 1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      )
    );
  }
}