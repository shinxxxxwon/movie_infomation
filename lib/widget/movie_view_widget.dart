import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_infomation/blocs/movie_bloc.dart';
import 'package:movie_infomation/blocs/tab_button_bloc.dart';
import 'package:movie_infomation/models/item_model.dart';

class MovieViewWidget extends StatefulWidget {


  MovieViewWidget({Key? key}) : super(key: key);


  @override
  State<MovieViewWidget> createState() => _MovieViewWidgetState();
}

class _MovieViewWidgetState extends State<MovieViewWidget> {

  int selectedIndex = 0;
  int index = 0;
  Stream<ItemModel> _stream = movieBloc.nowplayingAllMovies;

  @override
  void initState() {
    // TODO: implement initState
    tabButtonBloc.stateStream.listen((state) {
      setState(() {
        selectedIndex = state.selectedIndex;
        index++;

        if(selectedIndex == 0){
          _stream = movieBloc.nowplayingAllMovies;
        }
        else if(selectedIndex == 1){
          _stream = movieBloc.upcommingAllMovies;
        }
        else{
          _stream = movieBloc.popularAllMovies;
        }

      });
    });
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  _getStream() async {
    if(selectedIndex == 0){
      _stream = movieBloc.nowplayingAllMovies;
    }
    else if(selectedIndex == 1){
      _stream = movieBloc.upcommingAllMovies;
    }
    else{
      _stream = movieBloc.popularAllMovies;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    _getStream();

    print('selectedIndex: $selectedIndex');
    print('_stream: $_stream');

    return StreamBuilder(
      stream: _stream,
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }
        else if (snapshot.hasData) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data?.results.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: _size.width / _size.height,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(_size.width * 0.01),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].poster_path}',
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          );
        }
        else if(snapshot.hasError){
          print('snapshot error');
        }

          return const Text('???');
      },
    );
  }
}

