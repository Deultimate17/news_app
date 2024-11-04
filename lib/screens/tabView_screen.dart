import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/network/tabModel.dart';

class TabViewScreen extends StatefulWidget {
  final int index;
  final List<dynamic> articles;
  const TabViewScreen({super.key, required this.index, required this.articles});

  @override
  State<TabViewScreen> createState() => _TabViewScreenState();
}

class _TabViewScreenState extends State<TabViewScreen> {
  String title = '';
  String source = '';
  String author = '';
  String imageUrl = '';
  String publishedAt = '';
  String content = '';
  String post = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setArticlesDetails();
  }

  void setArticlesDetails() {
    final article = widget.articles[widget.index];
    setState(() {
      title = article['title'] ?? 'No title';
      source = article['source']['name'] ?? 'BBC News';
      author = article['author'] ?? 'Not available';
      imageUrl = article['urlToImage'] ?? '';
      publishedAt = article['publishedAt'] ?? 'Not available';
      content = article['content'] ?? 'Not available';
      post = article['url'] ?? 'Not available';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
              Row(
                children: [
                  const SizedBox(
                    height: 70,
                    child: VerticalDivider(
                      color: Colors.greenAccent,
                      width: 20.0,
                      thickness: 5,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          source
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Text(author),
                      const SizedBox(height: 6.0,),
                      Text(publishedAt),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 30.0,),

              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  image: imageUrl != null ? DecorationImage(
                    image: CachedNetworkImageProvider(imageUrl),
                    fit: BoxFit.cover,
                  ) : const DecorationImage(
                      image: AssetImage(
                          'assets/splash/Frame 222.png'
                      ),
                      fit: BoxFit.cover
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Text(
                content,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontSize: 18.0
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text('View the full post: $post')
            ]
        ),
      ),
    );
  }
}
