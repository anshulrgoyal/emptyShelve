class Movie{
  String poster;
  String id;
  String name;
  Movie.fromJSON(Map jsonMap){
    this.poster=jsonMap['poster'];
    this.id=jsonMap['id'];
    this.name=jsonMap['name'];
  }
  Map<String,dynamic> toMap(Movie movie){
    Map<String,dynamic> movieMap=Map<String,dynamic>();
    movieMap['poster']=this.poster;
    movieMap['id']=this.id;
    movieMap['name']=this.name;
    return movieMap;
  }
}