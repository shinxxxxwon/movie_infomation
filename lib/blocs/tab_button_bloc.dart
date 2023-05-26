
import 'dart:async';
import 'package:movie_infomation/models/tab_button_model.dart';


class TabButtonBloc{
  final _stateController = StreamController<TabButtonModel>.broadcast();
  Stream<TabButtonModel> get stateStream => _stateController.stream;

  void selectButton(int selectedIndex) {
    _stateController.sink.add(TabButtonModel(selectedIndex));
  }

  void dispose() {
    _stateController.close();
  }
}

TabButtonBloc tabButtonBloc = TabButtonBloc();