import 'dart:convert';

import 'package:http/http.dart';

import '../util/news_util.dart';

const List<String> queryList = [
  'sport',
  'politics',
  'business',
  'health',
  'travel',
  'science',
  'cryptocurrency',
  'entertainment'
];

class TabModel {
  Future<Map<String,dynamic>> getNews() async{
    DateTime today = Util.getNow();
    DateTime yesterday = Util.getYesterday();

    String fromDate = '${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2,'0')}';
    String toDate = '${today.year}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2, '0')}';

    Map<String,dynamic> newsData = {};

    for (String query in queryList) {
      var finalUrl = "https://newsapi.org/v2/everything?q=$query&from=$fromDate&to=$toDate&sortBy=popularity&apiKey=${Util.appId}";
     // print(finalUrl);

      try {
        final response = await get(Uri.parse(Uri.encodeFull(finalUrl)));
        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);
          newsData[query] = decodedData['articles'];
          // print(newsData);
        } else {
          throw Exception('Error getting News $query');
        }
      } catch (e) {
        print('Error fetching news for $query: $e');
        newsData[query] = [];
      }
    }
    return newsData;
  }

}