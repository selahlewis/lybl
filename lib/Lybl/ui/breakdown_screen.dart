import 'package:flutter/material.dart';
import 'package:lybl_mobile/Lybl/ui/answer_screen.dart';
import 'package:lybl_mobile/Lybl/ui/home_screen.dart';
import 'package:lybl_mobile/Lybl/ui/info_screen.dart';
import 'package:lybl_mobile/Lybl/ui/modules_screen.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class BreakDown extends StatefulWidget {
  BreakDown();

  @override
  createState() => new BreakDownScreenState();
}

class BreakDownScreenState extends State<BreakDown> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  leading: BackButton(color: Colors.white),
                  expandedHeight: 50.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(HomeScreenState.pageTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                  ),
                  backgroundColor: Color(0xFF470223),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black87,
                    indicator: BubbleTabIndicator(
                        indicatorHeight: 10,
                        tabBarIndicatorSize: TabBarIndicatorSize.label,
                        indicatorColor: Color(0xFF470223),
                        indicatorRadius: 10,
                        padding: EdgeInsets.all(10)),
                    tabs: [
                      Tab(text: "Info"),
                      Tab(text: "Modules"),
                      Tab(text: "Saved"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              InfoScreen(),
              ModulesScreen(),
              AnswerScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
