import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/network/tabModel.dart';
import 'package:news_app/screens/tabView_screen.dart';

import 'details_screen.dart';

class TabviewallScreen extends StatefulWidget {
  final int index;
  const TabviewallScreen({super.key, required this.index});

  @override
  State<TabviewallScreen> createState() => _TabviewallScreenState();
}

class _TabviewallScreenState extends State<TabviewallScreen> {
  List<dynamic> tabArticles = [];
  bool isLoading = true;
  String title = '';
  String imageUrl = '';

  Future<void> getTabData() async {
    setState(() {
      isLoading = true;
    });
    try {
      TabModel tabModel = TabModel();
      var data = await tabModel.getNews();
      tabArticles = data[queryList[widget.index]];
      print(tabArticles);
      setState(() {
        title = tabArticles[widget.index]['title'] ?? 'No title';
        print(title);
        imageUrl = tabArticles[widget.index]['urlToImage'];
        isLoading = false;
      });
    } catch (e) {
      isLoading = false;
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTabData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
        child: SpinKitDoubleBounce(
          color: Colors.black,
          size: 100,
        ),
      ): Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.chevron_left),
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.zero,
                ),
                const Icon(Icons.grade_outlined),
              ],
            ),
            ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, int index) {
                  var imageUrl = tabArticles.isNotEmpty ? tabArticles[index]['urlToImage'] : null;
                  String title = tabArticles.isNotEmpty
                      ? tabArticles[index]['title'] ?? 'No title'
                      : 'No data available';
                  return GestureDetector(
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
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
                            ),
                            height: 250,
                          ),
                          const SizedBox(height: 30.0,),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,bottom: 20.0,right: 8.0),
                            child: Text(
                                title,
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ),


                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return TabViewScreen(index: index,
                                articles: tabArticles,
                            );
                          }
                      ));
                    },
                  );
                },
                separatorBuilder: (context,int index) {
                  return const SizedBox(
                    height: 30.0,
                  );
                },
                itemCount: tabArticles.length
            )
          ],
        ),
      ),
    );
  }
}
