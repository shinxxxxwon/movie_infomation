
import 'package:movie_infomation/blocs/movie_bloc.dart';

class SeatsBloc{

  List<List<int>> seats = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  ];


  Map<int, List<List<int>>> movieSeats = {};


  void seatsInit(int movieId){
    for(int i=0; i<seats.length; i++){
      for(int j=0; j<seats[i].length; j++){
        if(movieSeats[movieId]![i][j] !=  2){
          seats[i][j] = 0;
        }
      }
    }
  }


  void updateSeats(List<int> select){
    int col = 0, row = 0;
    for(int i=0; i<select.length; i++){
      col = select[i] ~/ 10;
      row = select[i] % 10;

      seats[col][row] = 1;
    }
  }

}

SeatsBloc seatsBloc = SeatsBloc();