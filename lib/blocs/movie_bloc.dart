
import 'dart:async';

import 'package:movie_infomation/models/item_model.dart';
import 'package:movie_infomation/resource/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc{
  final Repository _repository = Repository();
  final _moviesFetcher = StreamController<ItemModel>();

  Stream<ItemModel> get allMovies => _moviesFetcher.stream;

  void fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  void dispose(){
    _moviesFetcher.close();
  }
}

final movieBloc = MovieBloc();