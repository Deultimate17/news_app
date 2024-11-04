import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_app/util/news_util.dart';

class Network {
  Future getNews() async{
    DateTime today = Util.getNow();
    DateTime yesterday = Util.getYesterday();

    String fromDate = '${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2,'0')}';
    String toDate = '${today.year}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2, '0')}';

    var finalUrl = "https://newsapi.org/v2/everything?q=trending&from=$fromDate&to=$toDate&sortBy=popularity&apiKey=${Util.appId}";

    final response = await get(Uri.parse(Uri.encodeFull(finalUrl)));
   // print('URL: ${Uri.encodeFull(finalUrl)}');

    if (response.statusCode == 200) {
     //  print('weather data: ${response.body}');
      var decodedData = jsonDecode(response.body);
      return decodedData;
    } else {
      throw Exception('Error getting News');
    }

    }
}