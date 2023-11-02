import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_task/models/categories_model.dart';
import 'package:news_app_task/models/headline_model.dart';
class NewsRepo{

  Future<NewsHeadLineModel> fetchNewsHeadLines(sourceName) async {
    NewsHeadLineModel model = NewsHeadLineModel();
    try{
      String url;

         url = 'https://newsapi.org/v2/top-headlines?sources=$sourceName&apiKey=YOUR-API-KEY';

      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        model =  NewsHeadLineModel.fromJson(body );
      }
      else
      {
        throw Exception('error');
      }
    }
    catch(error){
      Fluttertoast.showToast(msg: error.toString());
    }
    return model;
  }//fetch News Head Lines



  Future<CategoriesModel> fetchNews() async {
    CategoriesModel model = CategoriesModel();
    try{
      String url;

      url = 'https://newsapi.org/v2/everything?q=general&apiKey=YOUR-API-KEY';

      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        model =  CategoriesModel.fromJson(body );
      }
      else
      {
        throw Exception('error');
      }
    }
    catch(error){
      Fluttertoast.showToast(msg: error.toString());
    }
    return model;
  }//fetch News





}
