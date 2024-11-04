import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/news_pages.dart';
import 'package:news_app/network/network.dart';
import 'package:news_app/screens/articles_screen.dart';
import 'package:news_app/screens/details_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/screens/tabViewAll_screen.dart';
import 'package:news_app/screens/tabView_screen.dart';

import '../network/tabModel.dart';


class HomePage extends StatefulWidget {
  static MaterialPage page() {
    return MaterialPage(
      name: NewsPages.home,
        key: ValueKey(NewsPages.home),
        child: const HomePage()
    );
  }
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   List<dynamic> articles = [];
   List<dynamic> tabArticles = [];
   int selectedIndex = 0;
   var title = '';
   bool isLoading = true;
   bool isWaiting = true;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Network network = Network();
      var data = await network.getNews();
      setState(() {
        articles = data['articles'];
        isLoading = false;
      });
      // print(articles);
    } catch(e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  Future<void> getTabData() async {
    setState(() {
      isWaiting = true;
    });
    try {
      TabModel tabModel = TabModel();
      var data = await tabModel.getNews();
      setState(() {
        tabArticles = data[queryList[selectedIndex]];
        isWaiting = false;
      });
       print(data);
       print(tabArticles);
    } catch (e) {
      setState(() {
        isWaiting = false;
      });
      print(e);
    }
  }


   @override
   void initState() {
     // TODO: implement initState
     super.initState();
     getData();
     getTabData();
   }

  List<Text> getTabBarItems() {
    return queryList.map((category) => Text(category.toUpperCase())).toList();
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: DefaultTabController(
          length: queryList.length,
          child: Scaffold(
            body: isLoading
              ? const Center(
              child: SpinKitDoubleBounce(
                color: Colors.black,
                size: 100,
              ),
            )
             : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                  const SizedBox(height: 16.0,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                          'assets/splash/Frame 222.png',
                        width: 100,
                      ),
                      const Icon(Icons.notifications_none_outlined)
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  textFieldView(),
                  const SizedBox(height: 12.0,),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Trending'),
                      TextButton(
                        child: const Text(
                            'See all',
                          style: TextStyle(
                              color: Colors.black
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const ArticlesScreen();
                              }
                          ));
                        },
                      ),
                    ]
                  ),

                  const SizedBox(height: 20.0,),
                  SizedBox(
                    height: 220,
                    child: ListView.separated(
                      shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, int index) {
                        var imageUrl = articles[index]['urlToImage'];
                        String title = articles[index]['title'];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return DetailsScreen(index: index, articles: articles,);
                                  }
                              ));
                            },
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              width: screenWidth - 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: imageUrl != null ? DecorationImage(
                                    image: CachedNetworkImageProvider(imageUrl),
                                  fit: BoxFit.cover,
                                ) : const DecorationImage(
                                    image: AssetImage(
                                        'assets/splash/Frame 222.png'
                                    ),
                                  fit: BoxFit.contain
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),
                                            bottomRight: Radius.circular(20.0)),
                                        color: Colors.black54,
                                      ),
                                    child: Text(
                                        title ?? 'No Title',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                        ),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                          ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, int index) {
                          return const SizedBox(width: 10.0,);
                        },
                        itemCount: articles.length
                    ),
                  ),
                  const SizedBox(height: 16.0,),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Latest'),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return TabviewallScreen(index: selectedIndex,);
                                  }
                              ));
                            },
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                color: Colors.black
                              ),
                            )
                        )
                      ]
                  ),
                  TabBar(
                      tabs: getTabBarItems(),
                    isScrollable: true,
                    onTap: (int index) {
                        setState(() {
                          selectedIndex = index;
                        });
                         getTabData();
                    },
                    tabAlignment: TabAlignment.start,
                  ),
                  const SizedBox(height: 16.0,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: isWaiting
                        ? const Center(
                      child: SpinKitDoubleBounce(
                        color: Colors.black,
                        size: 100,
                      ),
                    ) :
                    TabBarView(
                        children: queryList.map((category) {
                          return SizedBox(
                            height: 150,
                            child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, int index) {
                                  var imageUrl = tabArticles.isNotEmpty ? tabArticles[index]['urlToImage'] : null;
                                  String title = tabArticles.isNotEmpty
                                      ? tabArticles[index]['title'] ?? 'No title'
                                      : 'No data available';
                                  String author = tabArticles.isNotEmpty
                                      ? tabArticles[index]['author'] ?? 'No author'
                                      : '';
                                  return GestureDetector(
                                    child: SizedBox(
                                      height: 120,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              alignment: Alignment.bottomLeft,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  image: imageUrl != null ? DecorationImage(
                                                      image: CachedNetworkImageProvider(imageUrl),
                                                      fit: BoxFit.cover,

                                                  ) : const DecorationImage(
                                                      image: AssetImage(
                                                          'assets/splash/Frame 222.png'
                                                      ),
                                                      fit: BoxFit.contain
                                                  )
                                              )
                                          ),
                                          const SizedBox(width:16.0),
                                          Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      title,
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 18,
                                                          color: Colors.black
                                                      ),
                                                      maxLines: 2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Text(author)
                                                ],
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) {
                                            return TabViewScreen(index: index, articles: tabArticles,);
                                          }
                                          ));
                                    },
                                  );
                                },
                                separatorBuilder: (context,int index) {
                                  return const SizedBox(height: 20.0,);
                                },
                                itemCount: tabArticles.length
                            ),
                          );
                        }).toList()
                    ),
                  )

                ],
              ),
            ),
          ),
        )
    );
  }


  Widget textFieldView() {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          contentPadding: const EdgeInsets.all(8)
        ),
      ),
    );
  }
}

