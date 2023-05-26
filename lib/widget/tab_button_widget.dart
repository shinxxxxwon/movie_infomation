import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_infomation/blocs/tab_button_bloc.dart';

class TabButtonWidget extends StatefulWidget {
  int? index;
  String? title;
  TabButtonWidget({Key? key, this.index, this.title}) : super(key: key);

  @override
  State<TabButtonWidget> createState() => _TabButtonWidgetState();
}

class _TabButtonWidgetState extends State<TabButtonWidget> {
  int selectedIndex = 0;

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final isSelected = selectedIndex == widget.index;
    final _size = MediaQuery.of(context).size;
    final _width = _size.width;
    final _height = _size.height;
    final _fontSize = _size.width * 0.03;

    return GestureDetector(
      onTap: () {
        tabButtonBloc.selectButton(widget.index ?? 0);
      },
      child: Column(
        children: <Widget>[

          Expanded(
            flex: 10,
            child: Container(
              width: _width,
              height: 30,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Text(
                widget.title ?? "null",
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: _fontSize
                ),
              ),
            ),
          ),

          Expanded(
            flex: 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _width,
              height: 10,
              // margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
