import '../models/movie.dart';
class Details{
  String title;
  String runtime;
 String year;
  String story;
  List<String> director;
  List<String> writers;
 List<String> genre;
 String rating;
  String poster;
  List<Movie> related;
  List<String> stars;
  bool isTVShow;
  String episodes;
  int seasons;

  Details.fromJSON(Map jsonMap){
    print(jsonMap);
    this.title=jsonMap['title'];
    this.rating=jsonMap['rating'];
    this.runtime=jsonMap['runtime'];
    this.year=jsonMap['year'];
    this.story=jsonMap['story'];
    this.director=List.from(jsonMap['director']??jsonMap['directors']??jsonMap['creators']??jsonMap['creator']??[]);
    this.writers=List.from(jsonMap['writers']??jsonMap['writer']??jsonMap['creators']??jsonMap['creator']??[]
    );
    this.genre=List.from(jsonMap['genre']??[]);
    this.poster=jsonMap['poster'];
    this.related=List.from(jsonMap['related']).map((movie)=>Movie.fromJSON(movie)).toList();
    this.stars=List.from(jsonMap['stars']??[]);
    this.isTVShow=jsonMap.containsKey('episodes');
    this.episodes=jsonMap['episodes'];
    this.seasons=int.parse(jsonMap['seasons']??'0');
  }
}