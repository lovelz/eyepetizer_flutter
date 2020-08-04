import 'package:eyepetizer_flutter/page/community/community_page.dart';
import 'package:eyepetizer_flutter/page/home/home_page.dart';
import 'package:eyepetizer_flutter/page/main_provider.dart';
import 'package:eyepetizer_flutter/page/mine/mine_page.dart';
import 'package:eyepetizer_flutter/page/notification/notification_page.dart';
import 'package:eyepetizer_flutter/res/colors.dart';
import 'package:eyepetizer_flutter/res/dimens.dart';
import 'package:eyepetizer_flutter/res/gaps.dart';
import 'package:eyepetizer_flutter/util/theme_utils.dart';
import 'package:eyepetizer_flutter/widgets/double_tap_back_exit_app.dart';
import 'package:eyepetizer_flutter/widgets/load_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();

}

class _MainPageState extends State<MainPage> {

  var _pageList;
  var _appBarTitles = ['首页', '社区', '', '通知', '我的'];
  final _pageController = PageController();

  MainProvider provider = MainProvider();

  List<BottomNavigationBarItem> _list;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    _pageList = [
      HomePage(),
      CommunityPage(),
      NotificationPage(),
      MinePage(),
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      var _tabImages = [
        [
          const LoadAssetImage('btn_home_page_normal', width: 23.0, height: 23.0,),
          const LoadAssetImage('btn_home_page_selected', width: 23.0, height: 23.0,)
        ],
        [
          const LoadAssetImage('btn_community_normal', width: 23.0, height: 23.0,),
          const LoadAssetImage('btn_community_selected', width: 23.0, height: 23.0,)
        ],
        [
          const LoadAssetImage('btn_release_normal', width: 36.0, height: 36.0,),
          const LoadAssetImage('btn_release_normal', width: 36.0)
        ],
        [
          const LoadAssetImage('btn_notification_normal', width: 23.0, height: 23.0,),
          const LoadAssetImage('btn_notification_selected', width: 23.0, height: 23.0,)
        ],
        [
          const LoadAssetImage('btn_mine_normal', width: 25.0, height: 23.0,),
          const LoadAssetImage('btn_mine_selected', width: 25.0, height: 23.0,)
        ],
      ];
      _list = List.generate(5, (index) {
        bool isCenter = index == 2;
        return BottomNavigationBarItem(
          icon: _tabImages[index][0],
          activeIcon: _tabImages[index][1],
          title: isCenter ? Gaps.empty : Padding(
            padding: const EdgeInsets.only(top: 1.5),
            child: Text(
              _appBarTitles[index],
              key: Key(_appBarTitles[index]),
            ),
          ),
        );
      });
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
          bottomNavigationBar: Consumer<MainProvider>(
            builder: (_, provider, __) {
              return BottomNavigationBar(
                backgroundColor: ThemeUtils.getBackgroundColor(context),
                items: _buildBottomNavigationBarItem(),
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.value,
                elevation: 2.0,
                iconSize: 21.0,
                selectedFontSize: Dimens.font_sp10,
                unselectedFontSize: Dimens.font_sp10,
                selectedItemColor: Colours.select_color,
                unselectedItemColor: Colours.unselect_color,
                onTap: (index) {
                  if (index == 2) {
                    Fluttertoast.showToast(msg: 'fffff', textColor: Colours.unselect_color);
                  } else {
                    if (index > 2) {
                      index--;
                    }
                    _pageController.jumpToPage(index);
                  }
                },
              );
            },
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: onPageChanged,
            children: _pageList,
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }

  void onPageChanged(int index) {
    if (index >= 2) {
      index++;
    }
    provider.value = index;
  }

}