import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'pages/DiscoveryPage.dart';
import 'pages/MyInfoPage.dart';
import 'pages/NewsListPage.dart';
import 'pages/TweetsListPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyOSCClientState();
}

class MyOSCClientState extends State<MyApp> {
  int _tabIndex = 0;
  final tabTextStyleNormal = new TextStyle(color: const Color(0xff969696));
  final tabTextStyleSelected = new TextStyle(color: const Color(0xff63ca6c));
  var tabImages;
  var _body;

  var appBarTitles = ['资讯', '动弹', '发现', '我的'];

  void initData() {
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('images/ic_nav_news_normal.png'),
          getTabImage('images/ic_nav_news_actived.png')
        ],
        [
          getTabImage('images/ic_nav_tweet_normal.png'),
          getTabImage('images/ic_nav_tweet_actived.png')
        ],
        [
          getTabImage('images/ic_nav_discover_normal.png'),
          getTabImage('images/ic_nav_discover_actived.png')
        ],
        [
          getTabImage('images/ic_nav_my_normal.png'),
          getTabImage('images/ic_nav_my_pressed.png')
        ]
      ];
    }

    _body = new IndexedStack(
      children: <Widget>[
        new NewsListPage(),
        new TweetsListPage(),
        new DiscoveryPage(),
        new MyInfoPage()
      ],
      index: _tabIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    initData();

    return new MaterialApp(
      theme: new ThemeData(primaryColor: const Color(0xFF63CA6C)),
      home: new Scaffold(
        drawer:
            new Drawer(child: new Center(child: new Text("this is a drawer"))),
        appBar: new AppBar(
          title: new Text(appBarTitles[_tabIndex],
              style: new TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white),
        ),
        body: _body,
        bottomNavigationBar: new CupertinoTabBar(
            items: getBottonNavItems(),
            currentIndex: _tabIndex,
            onTap: (index) {
              setState(() {
                _tabIndex = index;
              });
            }),
      ),
    );
  }

  List<BottomNavigationBarItem> getBottonNavItems() {
    List<BottomNavigationBarItem> list = new List();
    for (int i = 0; i < 4; i++) {
      list.add(new BottomNavigationBarItem(
          icon: getTabIcon(i), title: getTabTitle(i)));
    }
    return list;
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    } else {
      return tabTextStyleNormal;
    }
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    } else {
      return tabImages[curIndex][0];
    }
  }

  Text getTabTitle(int curIndex) {
    return new Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }

  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }
}
