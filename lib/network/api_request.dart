import 'dart:convert';

import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_news/const/const.dart';
import 'package:flutter_news/model/news.dart';
import 'package:http/http.dart' as http;


News parsNews(String responseBody)
{
var l = json.decode(responseBody);
var news = News.fromJson(l);
return news;
}
Future<News> fetchNewsByCategory(String category) async{
   var url = Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e89ced8ae56d464fa4f9bcead39210d9");
  var response = await http.get(url);
  
  
 // final response = await http.get(
 //   '$mainurl$topHeadLines?language=en&category=$&apiKey=$apikey');
  if (response.statusCode == 200)
  return compute(parsNews,response.body);
else if(response.statusCode == 404)
throw Exception('Not Found 404');
else throw Exception('Can not get News');
}