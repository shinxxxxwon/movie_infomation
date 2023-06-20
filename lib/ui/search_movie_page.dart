import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../blocs/movie_bloc.dart';
import '../models/item_model.dart';
import 'detail_page.dart';

class SearchMoviePage extends StatelessWidget {
  String? searchText;

  SearchMoviePage({Key? key, this.searchText}) : super(key: key);

  Widget _backPage(BuildContext context, Size size) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(size.width * 0.03),
      width: size.width,
      height: size.height * 0.1,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: size.width * 0.1,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              "Movie List",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.06,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _movieListView(Size size) {
    return StreamBuilder(
      stream: movieBloc.searchAllMovies,
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        return ListView.builder(
          itemCount: snapshot.data!.results.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[

                GestureDetector(
                  onTap: (){
                    Platform.isAndroid
                        ? Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(snapshot: snapshot, index: index)))
                        : Navigator.push(context, CupertinoPageRoute(builder: (context) => DetailPage(snapshot: snapshot, index: index)));
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: size.width,
                          height: size.height * 0.2,
                          padding: EdgeInsets.all(size.width * 0.03),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/original${snapshot.data!.results[index].poster_path}',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: size.width,
                          height: size.height * 0.2,
                          padding: EdgeInsets.all(size.width * 0.02),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data!.results[index].title,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                snapshot.data!.results[index].vote_average.toStringAsFixed(1),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.03,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1),
                  child: Opacity(
                    opacity: 0.1,
                    child: Divider(
                      color: Colors.grey,
                      thickness: size.width * 0.01,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _pageView(BuildContext context, Size size) {
    return _movieListView(size);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    movieBloc.searchFetchAllMovies(searchText!);

    return Platform.isAndroid
        ? MaterialApp(
            home: Scaffold(
              backgroundColor: const Color(0xFF242A32),
              body: _pageView(context, _size),
            ),
          )
        : CupertinoApp(
            home: CupertinoPageScaffold(
              backgroundColor: const Color(0xFF242A32),
              child: _pageView(context, _size),
            ),
          );
  }
}
