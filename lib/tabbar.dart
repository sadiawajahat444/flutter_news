import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news/model/news.dart';
import 'package:flutter_news/network/api_request.dart';
import 'package:flutter_news/screens/news_details.dart';

import 'const/appcolor.dart';


class MainTabBar extends StatefulWidget {
  MainTabBar({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MainTabBarState createState() => _MainTabBarState();
}


class _MainTabBarState extends State<MainTabBar>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    new Tab(
      text: 'General',
    ),
    new Tab(
      text: 'Technology',
    ),
    new Tab(
      text: 'Sports',
    ),
    new Tab(
      text: 'Bussines',
    ),
    new Tab(
      text: 'Entertainment',
    ),
    new Tab(
      text: 'Health',
    ),
  ];
  TabController _tabController;

  @override
  void initState() {
    //TO DO :IMPLIMENT INIT state
    super.initState();
    _tabController = new TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    //TODO:IMPLIMENT DISPOSE
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          '   News App   ',
        )),
        bottom: TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BubbleTabIndicator(
              indicatorHeight: 30.0,
              indicatorColor:AppColors.deep_orange,
            
            
                
              tabBarIndicatorSize: TabBarIndicatorSize.tab),
          tabs: tabs,
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map((tab) {
          return FutureBuilder(
              future: fetchNewsByCategory(tab.text),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                else if (snapshot.hasData) {
                  var newsList = snapshot.data as News;
                  //Select top 10
                  //if length > 10, we will get from 0 ~ 10
                  //if length <10,we will get from 0 ~ x
                  //if length == null,we will get 0

                  var sliderList = newsList.articles != null
                      ? newsList.articles.length > 10
                          ? newsList.articles.getRange(0, 10).toList()
                          : newsList.articles
                              .take(newsList.articles.length)
                              .toList()
                      : [];

                  //Select articles excepts top

                  var contentList = newsList.articles != null
                      ? newsList.articles.length > 10
                          ? newsList.articles
                              .getRange(11, newsList.articles.length - 1)
                              .toList()
                          : []
                      : [];
                  return SafeArea(
                    child: Column(
                      children: [
                        CarouselSlider(
                            options: CarouselOptions(
                                aspectRatio: 16 / 9,
                                enlargeCenterPage: true,
                                viewportFraction: 0.8),
                            items: sliderList.map((item) {
                              return Builder(
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyNewDetail()),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            '${item.urlToImage}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              color: Color(0xAA333639),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Text(
                                                  '${item.title}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }).toList()),
                        Divider(
                          thickness: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'Trending*',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(
                          thickness: 3,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: contentList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyNewDetail(
                                            img: contentList[index].urlToImage,
                                            title: contentList[index].title,
                                            publishedAt: contentList[index].publishedAt,
                                            )),
                                    );

                                                                      },
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        '${contentList[index].urlToImage}',
                                        fit: BoxFit.cover,
                                        height: 80,
                                        width: 80,
                                      ),
                                    ),
                                    title: Text(
                                      '${contentList[index].title}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      '${contentList[index].publishedAt}',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  );
                } else
                  return Center(
                    child: CircularProgressIndicator(),
                  );
              });
        }).toList(),
      ),
    );
  }
}
