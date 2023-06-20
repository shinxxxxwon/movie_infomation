import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../blocs/seats_bloc.dart';
import '../models/item_model.dart';
import 'reservation_info_page.dart';

class ReservationPage extends StatefulWidget {
  final AsyncSnapshot<ItemModel>? snapshot;
  final int? index;

  const ReservationPage({Key? key, this.snapshot, this.index})
      : super(key: key);

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  
  List<String> seatName = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"];
  List<String> selectSeats = [];
  int price = 0;
  var comma = NumberFormat('###,###,###,###');
  
  Widget _header(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.1,
      padding: EdgeInsets.all(size.width * 0.03),
      child: Row(
        children: <Widget>[
          //뒤로가기
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Icon(Icons.arrow_back_ios_new,
                      color: Colors.white, size: size.width * 0.08)),
            ),
          ),

          Expanded(
            flex: 1,
            child: SizedBox(),
          ),

          //title
          Expanded(
            flex: 4,
            child: Container(
              width: size.width,
              height: size.height,
              alignment: Alignment.center,
              child: Text(
                widget.snapshot!.data!.results[widget.index!].title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.05,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _screenView(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.15,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Text(
            'screen',
            style: TextStyle(
              color: Colors.grey,
              fontSize: size.width * 0.03,
            ),
          ),

          CustomPaint(
            child: Container(
              padding: EdgeInsets.all(size.width * 0.02),
            ),
            painter: _Painter(
                padding: EdgeInsets.all(size.width * 0.02),
                avatarRoot: size,
                avatarChild: size.height * 0.15,
                pathColor: Colors.grey,
                strokeWidth: size.width * 0.02),
          ),
        ],
      ),
    );
  }

  Widget _seatsView(Size size){
    List<int> _selected = [];

    return Container(
      width: size.width,
      height: size.height * 0.45,
      padding: EdgeInsets.all(size.width * 0.03),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          childAspectRatio: 1/1,
        ),
        // itemCount: seatsBloc.movieSeats[widget.snapshot!.data!.results[widget.index!]]!.length ,
        itemCount: 100,
        itemBuilder: (BuildContext context, int index){
          int col = index ~/ 10;
          int row = index % 10;
          return Container(
                padding: EdgeInsets.all(size.width * 0.02),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      if(seatsBloc.movieSeats[widget.snapshot!.data!.results[widget.index!].id]![col][row] == 0){
                        seatsBloc.movieSeats[widget.snapshot!.data!.results[widget.index!].id]![col][row] = 1;
                        selectSeats.add('${seatName[col]}$row');
                        price += 10000;
                      }
                      else if(seatsBloc.movieSeats[widget.snapshot!.data!.results[widget.index!].id]![col][row] == 1){
                        seatsBloc.movieSeats[widget.snapshot!.data!.results[widget.index!].id]![col][row] = 0;
                        selectSeats.removeWhere((element) => element == '${seatName[col]}$row');
                        price -= 10000;
                      }
                      else{
                        null;
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: setSeatsColor(seatsBloc.movieSeats[widget.snapshot!.data!.results[widget.index!].id]![col][row]),
                      // color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }

  Color setSeatsColor(int selected){
    // print('select : $selected');
    if(selected == 0){
      return Colors.white;
    }
    else if(selected == 1){
      return Colors.orange;
    }
    else{
      return Colors.grey;
    }
  }

  Widget _seatGuid(Size size){
    return Container(
      width: size.width,
      height: size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Container(
            width: size.width * 0.03,
            height: size.width * 0.03,
            margin: EdgeInsets.only(left: size.width * 0.02, right: size.width * 0.01),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),

          Text(
            '예약 가능 좌석',
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.02,
            ),
          ),

          Container(
            width: size.width * 0.03,
            height: size.width * 0.03,
            margin: EdgeInsets.only(left: size.width * 0.02, right: size.width * 0.01),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),

          Text(
            '예약 불가능 좌석',
            style: TextStyle(
              color: Colors.grey,
              fontSize: size.width * 0.02,
            ),
          ),

          Container(
            width: size.width * 0.03,
            height: size.width * 0.03,
            margin: EdgeInsets.only(left: size.width * 0.02, right: size.width * 0.01),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),

          Text(
            '선태한 좌석',
            style: TextStyle(
              color: Colors.grey,
              fontSize: size.width * 0.02,
            ),
          ),

        ],

      ),
    );
  }

  Widget _selectedInfo(Size size){
    return Container(
      width: size.width,
      height: size.height * 0.2,
      padding: EdgeInsets.all(size.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '선택 좌석 : ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),

              for(int i=0; i<selectSeats.length; i++)
                Text(
                  (i == selectSeats.length - 1) ? selectSeats[i] : '${selectSeats[i]}, ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              
            ],
          ),

          SizedBox(height: size.height * 0.03,),

          Row(
            children: <Widget>[

              Expanded(
                flex: 1,
                child: Text(
                  comma.format(price),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.1,
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    for(int i=0; i<seatsBloc.movieSeats[widget.snapshot!.data!.results[widget.index!].id]!.length; i++){
                      for(int j=0; j<seatsBloc.movieSeats[widget.snapshot!.data!.results[widget.index!].id]![i].length; j ++){
                        if(seatsBloc.movieSeats[widget.snapshot!.data!.results[widget.index!].id]![i][j] == 1){
                          seatsBloc.movieSeats[widget.snapshot!.data!.results[widget.index!].id]![i][j] = 2;
                        }
                      }
                    }

                    Platform.isAndroid
                        ? Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationInfoPage(index: widget.index!, snapshot: widget.snapshot!, seatInfo: selectSeats,)))
                        : Navigator.push(context, CupertinoPageRoute(builder: (context) => ReservationInfoPage(index: widget.index!, snapshot: widget.snapshot!, seatInfo: selectSeats,)));
                  },
                  child: Container(
                    width: size.width,
                    height: size.height * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      '결제하기',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.07,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
          
        ],
      ),
    );
  }

  Widget _viewPage(Size size) {
    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        color: const Color(0xFF242A32),
        child: Column(
          children: <Widget>[
            //헤더
            _header(size),

            //스크린
            _screenView(size),

            //좌석
            _seatsView(size),

            //좌석 설명
            _seatGuid(size),

            //예약 선택 정보
            _selectedInfo(size),

          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    seatsBloc.seatsInit(widget.snapshot!.data!.results[widget.index!].id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Platform.isAndroid
        ? MaterialApp(
            home: Scaffold(
              backgroundColor: const Color(0xFF242A32),
              body: _viewPage(_size),
            ),
          )
        : CupertinoApp(
            home: CupertinoPageScaffold(
              backgroundColor: const Color(0xFF242A32),
              child: _viewPage(_size),
            ),
          );
  }
}

class _Painter extends CustomPainter {
  bool isLast = true;

  EdgeInsets? padding;

  Size? avatarRoot;
  double? avatarChild;
  Color? pathColor;
  double? strokeWidth;

  _Painter(
      {
      this.padding,
      this.avatarRoot,
      this.avatarChild,
      this.pathColor,
      this.strokeWidth}) {
    _paint = Paint()
      ..color = pathColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!
      ..strokeCap = StrokeCap.round;
  }

  Paint? _paint;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(avatarRoot!.width * 0.1, avatarRoot!.height * 0.1);
    path.cubicTo(
        avatarRoot!.width * 0.1,
        avatarRoot!.height * 0.1,
        avatarRoot!.width / 2,
        -avatarRoot!.height * 0.05,
        avatarRoot!.width - avatarRoot!.width * 0.1,
      avatarRoot!.height * 0.1,);
    canvas.drawPath(path, _paint!);

    if (!isLast) {
      canvas.drawLine(
        Offset(avatarRoot!.width / 2, 0),
        Offset(avatarRoot!.width / 2, size.height),
        _paint!,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
