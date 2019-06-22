import 'package:flutter/material.dart';
import 'package:flutter_demo/widget/loading_container.dart';
import 'package:flutter_demo/widget/search_bar.dart';
import 'package:flutter_demo/util/navigator_util.dart';
import 'package:flutter_demo/pages/search_page.dart';
import 'package:flutter_demo/widget/cached_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';


class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin{

  bool _loading = true; //页面加载状态

  //缓存页面
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    hideScreen();
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


   //跳转搜索页面
  void _jumpToSearch() {
    NavigatorUtil.push(
        context,
        SearchPage());
  }


  @override
  Widget build(BuildContext context) {
  
   return LoadingContainer(
      isLoading: _loading,
      child: Scaffold(
         appBar: _appBar,
         backgroundColor: Color(0xfff2f2f2),
         body: ListView(
           children: <Widget>[
             _banner 
           ],
         ),
      ),
    );
    
  }

 
  /*搜索栏*/
  Widget get _appBar {

    return  SearchAppBarWidget(
              elevation: 2.0,
              inputBoxClick: _jumpToSearch,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  highlightColor: Colors.black,
                  onPressed: () {
                    //Navigator.pop(context);
                  }),
               ); 

  }

  /*轮播图*/
  Widget get _banner {
    var bannerList = ['http://img.alicdn.com/tps/i4/TB1N01ncRGw3KVjSZFwSuvQ2FXa.jpg_q90_.webp',
                       'https://img.alicdn.com/simba/img/TB1lEBtc8Cw3KVjSZFuSuwAOpXa.jpg',
                       'https://img.alicdn.com/simba/img/TB13RYlXBGw3KVjSZFwSuvQ2FXa.jpg',
                       'https://img.alicdn.com/simba/img/TB1HThXc.GF3KVjSZFoSuvmpFXa.jpg',
                       'https://img.alicdn.com/tfs/TB1WYMlcliE3KVjSZFMXXbQhVXa-520-280.jpg_q90_.webp'
                       ];
    return Container(
      height: 140,
      child: Swiper(
        autoplay: true,
        loop: true,
        pagination: SwiperPagination(),
        itemCount: bannerList.length,
        itemBuilder: (BuildContext context, int index) {
          return CachedImage(
            imageUrl: bannerList[index],
            fit: BoxFit.fill,
          );
        },
        onTap: (index) {
       
        },
      ),
    );
  }

}