import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/network/network.dart';
import 'package:news_app/screens/details_screen.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  List<dynamic> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

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
                const Text('Trending'),
                const Icon(Icons.grade_outlined),
              ],
            ),
            ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, int index) {
                var imageUrl = articles.isNotEmpty ? articles[index]['urlToImage'] : null;
                String title = articles.isNotEmpty
                    ? articles[index]['title'] ?? 'No title'
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
                          return DetailsScreen(index: index, articles: articles,);
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
                itemCount: articles.length
            )
          ],
        ),
      ),
    );
  }
}
