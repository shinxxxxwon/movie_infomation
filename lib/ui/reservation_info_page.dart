import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_infomation/models/item_model.dart';

class ReservationInfoPage extends StatelessWidget {
  final AsyncSnapshot<ItemModel>? snapshot;
  final int? index;

  const ReservationInfoPage({Key? key, this.index, this.snapshot}) : super(key: key);

  Widget _pageView(Size size){
    return Container();
  }

  @override
  Widget build(BuildContext context) {

    Size _size = MediaQuery.of(context).size;

    return Platform.isAndroid
        ? MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF242A32),
        body: _pageView(_size),
      ),
    )
        : CupertinoApp(
      home: CupertinoPageScaffold(
        backgroundColor: const Color(0xFF242A32),
        child: _pageView(_size),
      ),
    );
  }
}
