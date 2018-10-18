import 'package:flutter/material.dart';
import '../helpers/httpRequest.dart';
import '../models/movie.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math';
import '../utils/components.dart';

final rnd = Random(400);
class HomePage extends StatefulWidget{
  HomePage(this.changeTheme);
  final Function changeTheme;
  @override
  State<StatefulWidget> createState() {
    return _HomePage(changeTheme);
  }
}
class _HomePage extends State<HomePage> {
  _HomePage(this.changeTheme);
  final Function changeTheme;
  String type='movie';
  String theme='dark';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(type=='tv'?Icons.tv:Icons.movie),
              onPressed: () {
                setState(() {
                  type=='tv'?type='movie':type='tv';
                });
              },
            ),
            IconButton(
              icon: Icon(theme=='light'?Icons.wb_incandescent:Icons.brightness_2),
              onPressed: () {
                changeTheme();
                setState(() {
                  theme=='dark'?theme='light':theme='dark';
                });
              },
            )
          ],
          title: Text('Empty Shelve'),
        ),
        body: FutureBuilder<List<Movie>>(
          initialData: List<Movie>(0),
          future: getMovies(type),
          builder:
              (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) =>
                  StaggeredGridView.countBuilder(
                    addAutomaticKeepAlives: true,
                    itemCount: snapshot.data.length,
                    primary: false,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    itemBuilder: (context, index) =>
                        Tile(snapshot.data[index], changeTheme),
                    staggeredTileBuilder: (index) => new StaggeredTile.fit(2),
                  ),
        ));
  }
}
