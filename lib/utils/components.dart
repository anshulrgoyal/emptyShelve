import 'package:flutter/material.dart';
import '../pages/movieDetailsPage.dart';
import '../models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';


class Tile extends StatelessWidget {

  const Tile(this.movie,[this.action]);

  final Movie movie;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MovieDetailsPage(movie.id,action)));
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                //new Center(child: new CircularProgressIndicator()),
                Center(
                  child: Container(
                    height: 300.0,
                    child: FadeInImage(
                      fit: BoxFit.fill,
                      placeholder: AssetImage('sunset.jpeg'),
                      image: CachedNetworkImageProvider(movie.poster),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: <Widget>[
                  Text(
                    movie.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}