import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/item_model.dart';
import '../widget/detail_widget.dart';

class DetailPage extends StatelessWidget {
  AsyncSnapshot<ItemModel>? snapshot;
  int? index;

  DetailPage({Key? key, this.index, this.snapshot}) : super(key: key);

  Widget _backPage(BuildContext context, Size size) {
    return Positioned(
      top: 30,
      left: 10,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back_ios_new,
            color: Colors.white, size: size.width * 0.1),
      ),
    );
  }

  Widget _backgroundImage(Size size){
    return Positioned(
      top: 0,
      left: 0,
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Opacity(
          opacity: 0.4,
          child: Image.network(
            'https://image.tmdb.org/t/p/original${snapshot?.data?.results[index ?? 0].poster_path}',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _posterView(Size size){
    return Positioned(
      top: size.height * 0.15,
      left: size.width * 0.1,
      child: SizedBox(
        width: size.width * 0.3,
        height: size.height * 0.25,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.network(
            'https://image.tmdb.org/t/p/original${snapshot?.data?.results[index ?? 0].poster_path}',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }


  Widget _pageView(BuildContext context, Size size) {
    return Stack(
      children: <Widget>[
        //배경
        _backgroundImage(size),

        //뒤로가기 아이콘 버튼
        _backPage(context, size),

        //상세정보
        DetailWidget(index: index!, snapshot: snapshot!),

        //포스터
        _posterView(size),


      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

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
