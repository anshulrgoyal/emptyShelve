import 'package:http/http.dart';
import 'dart:convert';
import '../models/movie.dart';
import '../models/details.dart';
import '../models/episode.dart';

final String baseUrl='https://emptyshelve.herokuapp.com/emptyshelve/version1/api';

Future<List<Movie>> getMovies(String type) async {
  Response response = await get(
      '$baseUrl/movies/trending?type=$type');
  if (response.statusCode == 200) {
    final List movies = (jsonDecode(response.body));
    return movies.map((val) => Movie.fromJSON(val)).toList();
  } else {
    return [];
  }
}

Future<Details> getMovieById(String id) async{
  Response response=await get('$baseUrl/movies/details/$id');
  return Details.fromJSON(jsonDecode(response.body));
}
Future<List<Episode>> getSeasonsById(String id,int season) async{
  print(season);
  Response response=await get('$baseUrl/tv/seasons/$id?seasons=$season');
  print(response.body);
  if(response.statusCode==200){
    final List episodes=jsonDecode(response.body)['episodes'];
    return episodes.map((val)=>Episode.fromJSON(val)).toList();
  }
  else{
    return [];
  }
}