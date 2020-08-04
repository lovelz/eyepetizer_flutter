

import 'package:eyepetizer_flutter/page/community/community_page.dart';
import 'package:eyepetizer_flutter/page/home/provider/home_page_provider.dart';
import 'package:eyepetizer_flutter/res/colors.dart';
import 'package:eyepetizer_flutter/res/gaps.dart';
import 'package:eyepetizer_flutter/res/styles.dart';
import 'package:eyepetizer_flutter/widgets/load_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>, SingleTickerProviderStateMixin {

  TabController _tabController;
  HomePageProvider provider = HomePageProvider();
  PageController _pageController = PageController(initialPage: 0);

  final tabs = ['发现', '推荐', '日报'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<HomePageProvider> (
      create: (_) => provider,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Gaps.hGap16,
                  LoadAssetImage('home_candle', width: 25.0,),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: TabBar(
                        onTap: (index) {
                          if (!mounted) {
                            return;
                          }
                          _pageController.jumpToPage(index);
                        },
                        controller: _tabController,
                        isScrollable: true,
                        labelStyle: StyleUtils.textSize14,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: Colours.select_color,
                        unselectedLabelColor: Colours.unselect_color,
                        labelColor: Colours.select_color,
                        indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                        indicatorWeight: 3,
                        tabs: tabs.map((e) => Tab(text: e,)).toList(),
                      ),
                    ),
                  ),
                  LoadAssetImage('home_search', width: 25.0,),
                  Gaps.hGap16,
                ],
              ),
            ),
            Gaps.line,
            Expanded(
              child: PageView.builder(
                key: const Key('pageView'),
                itemCount: tabs.length,
                onPageChanged: _onPageChange,
                controller: _pageController,
                itemBuilder: (_, int index) => CommunityPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onPageChange(int index) {
    _tabController.animateTo(index);
    provider.setIndex(index);
  }

  @override
  bool get wantKeepAlive => true;

}


