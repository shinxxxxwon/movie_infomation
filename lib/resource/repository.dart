
import '../models/item_model.dart';
import 'movie_api_provider.dart';

class Repository{
  final MovieApiProver movieApiProver = MovieApiProver();

  Future<ItemModel> popularFetchAllMovies() => movieApiProver.popularFetchMovieList();
  Future<ItemModel> nowPlayingFetchAllMovies() => movieApiProver.nowplayingFetchMovieList();
  Future<ItemModel> upcommingFetchAllMovies() => movieApiProver.upcommingFetchMovieList();
  Future<ItemModel> searchFetchAllMovies(String text) => movieApiProver.searchFetchMovieList(text);
}