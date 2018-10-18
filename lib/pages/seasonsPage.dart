import 'package:flutter/material.dart';
import '../helpers/httpRequest.dart';
import '../models/episode.dart';
import '../models/details.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SeasonsPage extends StatefulWidget {
  final Details details;
  final String id;
  SeasonsPage(this.id, this.details);
  @override
  State<StatefulWidget> createState() {
    return _SeasonsPage(id, details);
  }
}

class _SeasonsPage extends State<SeasonsPage> {
  final String id;
  final Details details;
List<Episode> initialData=[];
  int season = 1;
  _SeasonsPage(this.id, this.details);
  _buildBody(List<Episode> val) {
    if (val == null) {
      return Scaffold(
          body: Center(
        child: Text('Error :('),
      ));
    }
    if (val.length == 0) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (val.length > 0) {
      return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.apps),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) => BottomSheet(
                          onClosing: () {},
                          builder: (BuildContext context) => ListView(
                                children: List<int>.generate(details.seasons, (i) => i + 1)
                                    .map((int i) => ListTile(
                                  leading: Icon(Icons.all_inclusive),
                                          title: Text(i.toString()),
                                          onTap: () {
                                            setState(() {
                                              season = i;
                                              initialData=[];
                                            });
                                            Navigator.pop(context);
                                          },
                                        ))
                                    .toList(),
                              ),
                        ));
              },
            )
          ],
          title: Text('Season $season'),
        ),
        body: ListView.builder(
            itemCount: val.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
                  //  isThreeLine: true,
                  leading: Image(
                    image: CachedNetworkImageProvider(
                        val[index].poster.split('@._')[0] +
                            '@._V1_UY98_CR53,0,67,98_AL_.jpg'),
                  ),
                  title: Text(val[index].name),
                  subtitle: Text(val[index].story),
                  trailing: Text(val[index].rating),
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Episode>>(
      initialData: initialData,
      future: getSeasonsById(id, season),
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
          _buildBody(snapshot.data),
    );
  }
}
