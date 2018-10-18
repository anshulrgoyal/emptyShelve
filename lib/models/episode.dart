//name: $(`.eplist > div:nth-child(${i+1}) > div.info > strong > a`).text(),
//story: story.includes('about?') ? 'N/A' : story,
//airDate: $(`.eplist > div:nth-child(${i+1}) > .info > .airdate`).text().trim(),
//rating: $(`.eplist > div:nth-child(${i+1}) > .info > .ipl-rating-widget > .ipl-rating-star > .ipl-rating-star__rating`).text()

class Episode{
  String name;
  String story;
  String airDate;
  String rating;
  String poster;
  Episode.fromJSON(Map jsonMap){
    this.name=jsonMap['name'];
    this.rating=jsonMap['rating'];
    this.airDate=jsonMap['airDate'];
    this.story=jsonMap['story'].trim();
    this.poster=jsonMap['poster'];
  }
}