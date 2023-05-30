import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_infomation/blocs/movie_bloc.dart';
import 'package:movie_infomation/models/item_model.dart';
import 'package:movie_infomation/widget/movie_view_widget.dart';
import 'package:movie_infomation/widget/tab_button_widget.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  Widget _searchBar(Size size) {
    final _textSize = size.width * 0.04;

    return Platform.isAndroid
        ? TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "어떤 영화를 찾으시나요?",
              hintStyle: TextStyle(
                color: const Color(0xFF67686D),
                fontSize: _textSize,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search, color: Color(0xFF67686D)),
                onPressed: () {},
              ),
              fillColor: const Color(0xFF3A3F47),
            ),
          )
        : CupertinoTextField(
            controller: _searchController,
            placeholder: "어떤 영화를 찾으시나요?",
            placeholderStyle: TextStyle(
              color: const Color(0xFF67686D),
              fontSize: _textSize,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: const Color(0xFF3A3F47),
            ),
            suffix: CupertinoButton(
              child: const Icon(Icons.search, color: Color(0xFF67686D)),
              onPressed: () {},
            ),
          );
  }

  Widget _showMoviesList(Size size) {
    final _padding = size.width * 0.03;

    return Container(
      width: size.width,
      height: size.height * 0.3,
      child: StreamBuilder(
        stream: movieBloc.popularAllMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              // itemCount: snapshot.data?.results.length,
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(_padding),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/original${snapshot.data?.results[index].poster_path}',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    Positioned(
                      top: size.height * 0.18,
                      left: size.width * 0.02,
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          fontSize: size.width * 0.2,
                          color: const Color(0xFF242A32),
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(
                              offset: Offset(-1.5, -1.5),
                              color: Color(0xFF0296E5),
                            ),
                            Shadow(
                              offset: Offset(1.5, -1.5),
                              color: Color(0xFF0296E5),
                            ),
                            Shadow(
                              offset: Offset(1.5, 1.5),
                              color: Color(0xFF0296E5),
                            ),
                            Shadow(
                              offset: Offset(-1.5, 1.5),
                              color: Color(0xFF0296E5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _tabBar(Size size){
    int _select = 0;
    return Container(
      width: size.width,
      height: size.height * 0.06,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TabButtonWidget(index: 0, title: "현재 상영중",),
          ),
          Expanded(
            flex: 1,
            child: TabButtonWidget(index: 1, title: "개봉 예정"),
          ),
          Expanded(
            flex: 1,
            child: TabButtonWidget(index: 2, title: "인기 영화"),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    Size _size = MediaQuery.of(context).size;
    double _sidePadding = _size.width * 0.05;
    double _topPadding = _size.width * 0.1;

    return Container(
      margin: EdgeInsets.only(
          left: _sidePadding, right: _sidePadding, top: _topPadding),
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //검색 바
            _searchBar(_size),

            //영화 Top10
            _showMoviesList(_size),

            SizedBox(height: _size.height * 0.01,),

            //탭바
            _tabBar(_size),

            //영화 목록
            MovieViewWidget(),
          ],
        ),
      ),
    );
  }
}
