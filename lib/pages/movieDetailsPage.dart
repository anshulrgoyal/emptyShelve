import '../helpers/httpRequest.dart';
import 'package:flutter/material.dart';
import '../models/details.dart';
import '../utils/components.dart';
import './seasonsPage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailsPage extends StatelessWidget{
  Widget _tvShowEpisodes(Details val,BuildContext context){
    if(val.isTVShow){
      return  Row(
        children: <Widget>[
          Text('Episodes : ',style: TextStyle(fontSize: 15.0),),
          Expanded(
            child:  Text(val.episodes=='0 episodes'?'N/A':val.episodes.toString()),
          )

        ],
      );
    }
    else{
      return Container();
    }
  }
  Widget _tvShowSeasons(Details val,BuildContext context){
    if(val.isTVShow){
      return  Row(
        children: <Widget>[
          Text('Seasons : ',style: TextStyle(fontSize: 15.0),),
          Expanded(
            child:  Text(val.seasons==0?'N/A':val.seasons.toString()),
          ),
          IconButton(icon:Icon(Icons.details),onPressed: (){
       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>SeasonsPage(id,val)));
          },),

        ],
      );
    }
    else{
      return Container();
    }
  }
  final Function action;
  final String id;
  MovieDetailsPage(this.id,this.action);
  Widget _buildBody(val,BuildContext context){
    if(val is Map){
      return Scaffold(
        appBar: AppBar(
          title: Text('Loading...'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    else if(val is Details){
      return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),tooltip:'Add movie to wishlist',),
        appBar: AppBar(
          title: Text(val.title),
        ),
        body:
            ListView(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  margin: EdgeInsets.all(10.0),
                  child: Container(
                    //padding: EdgeInsets.all(10.0),
                    //padding: EdgeInsets.all(10.0),
                      child:
                      Image(image: CachedNetworkImageProvider(val.poster),fit:BoxFit.contain)

                  ),
                )
                ,
                Card(
                  shape: BeveledRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(20.0))),
                  margin: EdgeInsets.all(10.0),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                      child:
                      Column(
                        children:[
                          Row(children: <Widget>[
                            Text('Plot',style: TextStyle(fontSize: 20.0),)
                          ],),
                          SizedBox(height: 10.0,),
                          Text(val.story.trim())
                        ]
                      )

                  ),
                ),
                Card(
                  shape: BeveledRectangleBorder(borderRadius: BorderRadius.only(topLeft:Radius.circular(20.0))),
                  margin: EdgeInsets.all(10.0),
                  child: Container(
                      padding: EdgeInsets.all(20.0),
                      child:
                      Column(
                          children:[
                            Row(children: <Widget>[
                              Text('Details',style: TextStyle(fontSize: 20.0),)
                            ],),
                            SizedBox(height: 10.0,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Directors : ',style: TextStyle(fontSize: 15.0),),
                                Expanded(child: Text(val.director.join(',')),)
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Writers : ',style: TextStyle(fontSize: 15.0),),
                               Expanded(child:  Text(val.writers.join(' , ')),)
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Stars : ',style: TextStyle(fontSize: 15.0),),
                               Expanded(
                                 child:  Text(val.stars.join(' , ')),
                               )

                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Genre : ',style: TextStyle(fontSize: 15.0),),
                                Expanded(
                                  child:  Text(val.genre[0]==""?'N/A':val.genre.join(' , ')),
                                )

                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Year : ',style: TextStyle(fontSize: 15.0),),
                                Expanded(
                                  child:  Text(val.year),
                                )

                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Rating : ',style: TextStyle(fontSize: 15.0),),
                                Expanded(
                                  child:  Text(val.rating==""?'N/A':val.rating),
                                )

                              ],
                            ),
                           _tvShowEpisodes(val,context),
                          _tvShowSeasons(val,context),
                          ]
                      )

                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child:                 Text('Related Movies :',style: TextStyle(fontSize: 15.0),),
                    
                ),
                Container(
                  height:332.0,
                  child:  ListView(
                    scrollDirection: Axis.horizontal,
                    children: val.related.map((movie)=>Tile(movie)).toList(),
                  ),
                )
              ],
            )
      );
    }
    else{
      return Scaffold(
        body:Center(
          child: Text('Error :('),
        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: {'value':null},
      future: getMovieById(id),
      builder: (BuildContext context,AsyncSnapshot snapshot)=>_buildBody(snapshot.data,context),
      );
  }
}