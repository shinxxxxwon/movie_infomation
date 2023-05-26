import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_infomation/blocs/movie_bloc.dart';
import 'package:movie_infomation/ui/main_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movieBloc.fetchAllMovies();

    return Platform.isAndroid
        ? MaterialApp(
      themeMode: ThemeMode.dark,
      home:Scaffold(
        backgroundColor: const Color(0xFF242A32),
        body: MainPage(),
      ),
    )
        : CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.dark),
      home: CupertinoPageScaffold(
        backgroundColor: const Color(0xFF242A32),
        child: MainPage(),
      ),
    );
  }
}



