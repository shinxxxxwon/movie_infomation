import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_infomation/blocs/movie_bloc.dart';
import 'package:movie_infomation/blocs/tab_button_bloc.dart';
import 'package:movie_infomation/models/item_model.dart';

class MovieViewWidget extends StatefulWidget {
  const MovieViewWidget({Key? key}) : super(key: key);

  @override
  State<MovieViewWidget> createState() => _MovieViewWidgetState();
}

class _MovieViewWidgetState extends State<MovieViewWidget> {

  int selectedIndex = 0;

  Stream<ItemModel> _getStramData(){
    if(selectedIndex == 0){
      return movieBloc.nowplayingAllMovies;
    }
    else if(selectedIndex == 1){
      return movieBloc.upcommingAllMovies;
    }

    return movieBloc.nowplayingAllMovies;
  }

  @override
  void initState() {
    // TODO: implement initState
    tabButtonBloc.stateStream.listen((state) {
      setState(() {
        selectedIndex = state.selectedIndex;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: _getStramData(),
      builder: (context, AsyncSnapshot<ItemModel> snapshot){
        if(snapshot.hasData){
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data?.results.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height),
            ),
            itemBuilder: (BuildContext context, int index){
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
        return const CircularProgressIndicator();
      },

    );
  }
}

