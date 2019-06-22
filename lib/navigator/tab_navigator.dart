import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_demo/pages/home_page.dart';
import 'package:flutter_demo/pages/category_page.dart';
import 'package:flutter_demo/pages/cart_page.dart';
import 'package:flutter_demo/pages/my_page.dart';
import 'package:flutter_demo/pages/tab_page.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

class TabNavigator extends StatefulWidget {
 
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {

  final _defaultColor = Colors.grey;
  final _activeColor = Color(0xFFC91B3A);
  var _controller = PageController(initialPage: 0);
  int _currentIndex = 0;
  DateTime _lastPressedAt; //上次点击时间
    
  
  @override
  void initState() {
    hideScreen();
    getPackageInfo();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  
  //隐藏启动屏
  Future<void> hideScreen() async {
    Future.delayed(Duration(milliseconds: 2000), () {
      FlutterSplashScreen.hide();
    });
  }


  //获取packageInfo
  void getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    print(
        'appName:$appName,packageName:$packageName,version:$version,buildNumber:$buildNumber}');
  }


  //退出app
  Future<bool> exitApp() {

    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
        Fluttertoast.showToast(
          msg: "再按一次退出应用",
          backgroundColor: Colors.grey,
          toastLength: Toast.LENGTH_SHORT,
          fontSize: 14);

      //两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      return Future.value(false);
    }

    return Future.value(true);
  }


  //底部导航item
  BottomNavigationBarItem _bottomItem(IconData icon, String title, int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: _defaultColor,
        ),
        activeIcon: Icon(
          icon,
          color: _activeColor,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: _currentIndex != index ? _defaultColor : _activeColor),
        ));
  } 

  @override

  Widget build(BuildContext context) {

    return  Scaffold(

      body:  WillPopScope(

        child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _controller,
            children: <Widget>[
              HomePage(),
              CategoryPage(),
              CartPage(),
              MyPage(),
              TabPage()
            ],
        ),

        onWillPop: exitApp,

      ),

      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 12,
          unselectedFontSize: 12,
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomItem(Icons.home, '首页', 0),
            _bottomItem(Icons.category, '分类', 1),
            _bottomItem(Icons.shopping_cart, '购物车', 2),
            _bottomItem(Icons.account_circle, '我的', 3),
            _bottomItem(Icons.tab, '导航', 4),
          ]
        ),
    );
  }
}


 