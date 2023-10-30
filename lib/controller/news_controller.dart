import 'package:news_app_task/repo/news_repo.dart';
import '../models/headline_model.dart';
import '../models/categories_model.dart';

class NewsController{
  final _repo = NewsRepo();

  Future<NewsHeadLineModel> fetchNewsHeadLines(sourceName) async {
    var response = await _repo.fetchNewsHeadLines(sourceName);
    return response;
  }


  Future<CategoriesModel> fetchNews() async {
    var response = await _repo.fetchNews();
    return response;
  }


}