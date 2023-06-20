import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_infomation/main.dart';
import '../models/item_model.dart';
import 'main_page.dart';

class ReservationInfoPage extends StatelessWidget {
  final AsyncSnapshot<ItemModel>? snapshot;
  final int? index;
  final List<String>? seatInfo;

  const ReservationInfoPage(
      {Key? key, this.index, this.snapshot, this.seatInfo})
      : super(key: key);

  //header
  Widget _headerView(Size size) {
    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height * 0.1,
        alignment: Alignment.center,
        padding: EdgeInsets.all(size.width * 0.03),
        child: Text(
          'Reservation Info',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.06,
          ),
        ),
      ),
    );
  }

  Widget _revervationImage(Size size){
    final _padding = size.width * 0.15;
    return Container(
      width: size.width,
      height: size.height * 0.5,
      margin: EdgeInsets.only(top: _padding, left: _padding, right: _padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              'https://image.tmdb.org/t/p/original${snapshot!.data!.results[index!].poster_path}',
          ),
        ),
      ),
    );
  }

  Widget _reservationInfo(Size size){
    final _padding = size.width * 0.15;

    return Container(
      width: size.width,
      height: size.height * 0.1,
      margin: EdgeInsets.only(left: _padding, right: _padding),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
      ),
      child: Column(
        children: <Widget>[

          Expanded(
            flex: 1,
            child: Container(
              width: size.width,
              height: size.height,
              alignment: Alignment.center,
              padding: EdgeInsets.zero,
              child: Text(
                snapshot!.data!.results[index!].title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.05,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: Container(
              width: size.width,
              height: size.height,
              padding: EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text(
                    'seats: ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width * 0.03,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  for(int i=0; i<seatInfo!.length; i++)
                    Text(
                     i == seatInfo!.length - 1 ? seatInfo![i] : '${seatInfo![i]}, ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _okButton(BuildContext context, Size size){
    return GestureDetector(
      onTap: (){
        Platform.isAndroid
            ? Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()))
            : Navigator.push(context, CupertinoPageRoute(builder: (context) => MyApp()));
      },
      child: Container(
        width: size.width,
        height: size.height * 0.1,
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: size.width * 0.05,
          left: size.width * 0.3,
          right: size.width * 0.3,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          '확인',
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _pageView(BuildContext context, Size size) {
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.transparent,
      child: Column(
        children: <Widget>[

          _headerView(size),

          _revervationImage(size),

          _reservationInfo(size),
          
          _okButton(context, size)

        ],
      ),
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
