import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_infomation/blocs/movie_bloc.dart';
import 'package:movie_infomation/models/item_model.dart';
import 'package:movie_infomation/resource/movie_api_provider.dart';
import 'package:movie_infomation/ui/reservation_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailWidget extends StatefulWidget {
  final AsyncSnapshot<ItemModel>? snapshot;
  final int? index;

  DetailWidget({Key? key, this.index, this.snapshot}) : super(key: key);

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  late String _trailerUrl;
  late YoutubePlayerController _youtubeController;

  Widget _titleView(Size size) {
    return Container(
      width: size.width * 9,
      height: size.height * 0.15,
      alignment: Alignment.topLeft,
      child: Row(
        children: <Widget>[
          const Expanded(
            flex: 2,
            child: SizedBox(),
          ),
          Expanded(
            flex: 3,
            child: Text(
              widget.snapshot!.data!.results[widget.index!].title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.06,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _overView(Size size) {
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.25,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(size.width * 0.02),
              alignment: Alignment.centerLeft,
              child: Text(
                'Overview',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.05,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(size.width * 0.02),
              alignment: Alignment.topLeft,
              child: Text(
                widget.snapshot!.data!.results[widget.index!].overview,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                  fontSize: size.width * 0.04,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _releaseDateView(Size size) {
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.05,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(size.width * 0.02),
      child: Row(
        children: <Widget>[
          Text(
            'Release Date : ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.04,
            ),
          ),
          Text(
            widget.snapshot!.data!.results[widget.index!].release_date.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.04,
            ),
          ),
        ],
      ),
    );
  }

  Widget _trailerView(Size size) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(size.width * 0.02),
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(8.0),
            ),
        child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              width: size.width * 0.9,
              controller: _youtubeController,
            ),
            builder: (context, player) => player),
      ),
    );
  }

  Widget _reservationButton(Size size) {
    return TextButton(
        onPressed: () {
          Platform.isAndroid
              ? Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationPage(snapshot: widget.snapshot!, index: widget.index!)))
              : Navigator.push(context, CupertinoPageRoute(builder: (context) => ReservationPage(snapshot: widget.snapshot!, index: widget.index!)));
        },
        child: Container(
          width: size.width * 0.9,
          height: size.height * 0.1,
          alignment: Alignment.center,
          padding: EdgeInsets.all(size.width * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.red,
          ),
          child: Text(
            'Reservation',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size.width * 0.04),
          ),
        ),
    );
  }

  @override
  void initState() {
    _trailerUrl = 'https://www.youtube.com/watch?v=fZvdBUhHlAY';
    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(_trailerUrl)!,
    );
    super.initState();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _youtubeController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Positioned(
      top: _size.height * 0.25,
      left: _size.width * 0.05,
      child: Container(
        width: _size.width * 0.9,
        height: _size.height * 0.7,
        decoration: BoxDecoration(
          color: const Color(0xFF242A32),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: <Widget>[
            //타이틀
            _titleView(_size),

            //줄거리
            _overView(_size),

            //개봉일
            _releaseDateView(_size),

            SizedBox(height: _size.height * 0.1),

            //예약버튼
            _reservationButton(_size),

            //트레일러
            // _trailerView(_size),
          ],
        ),
      ),
    );
  }
}
