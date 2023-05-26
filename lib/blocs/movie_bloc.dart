
import 'dart:async';

import 'package:movie_infomation/models/item_model.dart';
import 'package:movie_infomation/resource/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc{
  final Repository _repository = Repository();
  final _popularMoviesFetcher = StreamController<ItemModel>();
  final _nowplayingMoviesFetcher = StreamController<ItemModel>();
  final _upcommingMoviesFetcher = StreamController<ItemModel>();

  Stream<ItemModel> get popularAllMovies => _popularMoviesFetcher.stream;
  Stream<ItemModel> get nowplayingAllMovies => _nowplayingMoviesFetcher.stream;
  Stream<ItemModel> get upcommingAllMovies => _upcommingMoviesFetcher.stream;

  void popularFetchAllMovies() async {
    ItemModel itemModel = await _repository.popularFetchAllMovies();
    _popularMoviesFetcher.sink.add(itemModel);
  }

  void nowplayingFetchAllMovies() async {
    ItemModel itemModel = await _repository.nowPlayingFetchAllMovies();
    _nowplayingMoviesFetcher.sink.add(itemModel);
  }

  void upCommingFetchAllMovies() async {
    ItemModel itemModel = await _repository.nowPlayingFetchAllMovies();
    _upcommingMoviesFetcher.sink.add(itemModel);
  }

  void dispose(){
    _popularMoviesFetcher.close();
    _nowplayingMoviesFetcher.close();
    _upcommingMoviesFetcher.close();
  }
}

final movieBloc = MovieBloc();