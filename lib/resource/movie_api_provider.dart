
import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/item_model.dart';

class MovieApiProver{
  final _apiKey = "6bdd6f36cb39f19fc91894a86183a8bd";

  Future<ItemModel> searchFetchMovieList(String text) async {
    Dio dio = Dio();

    final response = await dio.get("https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&query=$text");
    // print("response : ${response.data.toString()}");
    if (response.statusCode == 200) {
      return ItemModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ItemModel> popularFetchMovieList() async {
    Dio dio = Dio();

    final response = await dio.get("http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey");
    // print("response : ${response.data.toString()}");
    if (response.statusCode == 200) {
      return ItemModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ItemModel> nowplayingFetchMovieList() async {
    Dio dio = Dio();

    final response = await dio.get("http://api.themoviedb.org/3/movie/now_playing?api_key=$_apiKey");
    // print("response : ${response.data.toString()}");
    if (response.statusCode == 200) {
      return ItemModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ItemModel> upcommingFetchMovieList() async {
    Dio dio = Dio();

    final response = await dio.get("http://api.themoviedb.org/3/movie/upcoming?api_key=$_apiKey");
    // print("response : ${response.data.toString()}");
    if (response.statusCode == 200) {
      return ItemModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load post');
    }
  }

}