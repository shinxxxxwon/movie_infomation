import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_infomation/blocs/movie_bloc.dart';
import 'package:movie_infomation/models/item_model.dart';

class MovieViewWidget extends StatelessWidget {
  const MovieViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      width: _size.width,
      height: _size.height * 0.4,
      child: StreamBuilder(
        stream: movieBloc.popularAllMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot){
          if(snapshot.hasData){
            return GridView.builder(
              // itemCount: snapshot.data?.results.length,
              itemCount: 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index){
                return Image.network(
                  'https://image.tmdb.org/t/p/w185${snapshot.data?.results[index].poster_path}',
                  fit: BoxFit.cover,
                );
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
