import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/gallery_Image_page.dart';
import 'package:flutter_demo/util/navigator_util.dart';
import 'package:flutter_demo/widget/bottom_loading_container.dart';
import 'package:flutter_demo/widget/circular_image.dart';

class CommentPage extends StatefulWidget {
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> with AutomaticKeepAliveClientMixin{
  final String userPic = 'http://upload.jianshu.io/users/upload_avatars/11894008/b4480698-f027-4b38-ac3e-adc39db6bc9c.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/120/h/120';
  final String comment = '刚到家没多会，外观手感还不错，家里停电，还没联网使用，用过再来追评';
  final String userName ='橘黄色的猫';
  final  images = ['https://img.alicdn.com/bao/uploaded/i3/O1CN0182cRhx2LUMO3XbvrT_!!0-rate.jpg_400x400.jpg',
                   'https://img.alicdn.com/bao/uploaded/i2/O1CN01EiXK1I2LUMO4qPi7C_!!0-rate.jpg_400x400.jpg',
                   'https://img.alicdn.com/bao/uploaded/i2/O1CN01iR2lgC2LUMO5URc3p_!!0-rate.jpg_400x400.jpg',
                   'https://img.alicdn.com/bao/uploaded/i4/O1CN01cPoYMu2LUMO6akBzq_!!0-rate.jpg_400x400.jpg'
                  ];
  List data = [{'userPic':'','comment':'','images':''}];

   //Flutter的ListView中有一个ScrollController属性，通过监听这个滑动来实现加载更多
  ScrollController  scrollController = new ScrollController();
  bool loadMore = false; //上拉加载更多
  int count = 10;

   @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    //监听滑动到底部时，加载更多
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
        setState(() {
          loadMore =true;
        });
        _getMoreData();
      }
    });
    super.initState();
  }

  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        count = 10;
      });
    });
  }

  // 上拉加载更多
  Future _getMoreData() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
         count += 10;
         loadMore = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child:  _commentBlock,
    );
  }

  Widget get _comment {
    return Container(
      margin:  EdgeInsetsDirectional.only(start: 10,end: 10,top: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
               Padding(
                 padding: EdgeInsetsDirectional.only(start:10,top:10),
                 child: _userFacePic(userPic),
               ),
               Padding(
                 padding: EdgeInsets.only(left:4,top:8),
                 child: Text(userName),
               )

            ],
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsetsDirectional.only(start:10,end:10,top:10),
                child: Text(
                  comment,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 10,end:5),
                child: _showImages,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _userFacePic(url){
    return CircularImage(imageURL: url);
  }

  Widget get _showImages {
    List<Widget> list = new List<Widget>();
    var count = images.length > 3 ? 3 : images.length;
    var newImages =  images.sublist(0,count);

    newImages.forEach((val){
      list.add(Container(
        width: 100,
        height: 100,
        padding: EdgeInsetsDirectional.only(end:5),
        child: GestureDetector(
          onTap: _jumpToGalleryImage,
          child: Image.network(val),
        ),
      ));
    });

    return Row(
      children: list,
    );
  }

  Widget get _commentBlock {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child:RefreshIndicator(
        onRefresh:_onRefresh,
        child: ListView.builder(
          controller: scrollController,
          itemCount: count+1,
          itemBuilder:  _renderRow
        ),
      )
    );
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < count) {
      return Container(
        color: Color(0xFFDDDDDD),
        child: _comment,
      );
    }
    return BottomLoadingContainer(isLoadMore: true,);
  }

  void _jumpToGalleryImage(){
    NavigatorUtil.push(
      context,
      GalleryImagePage(images:images)
    );
  }
}