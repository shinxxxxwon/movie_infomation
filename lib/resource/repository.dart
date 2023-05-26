
import 'package:movie_infomation/models/item_model.dart';
import 'package:movie_infomation/resource/movie_api_provider.dart';

class Repository{
  final MovieApiProver movieApiProver = MovieApiProver();

  Future<ItemModel> fetchAllMovies() => movieApiProver.fetchMovieList();
}