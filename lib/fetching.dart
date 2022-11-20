import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'player.dart';

const String apikey = '764c7005ee3f09e27e1b99177e5fafa1';

class Personal extends StatefulWidget {
  List movie = [];
  int n;
  int ident;

  Personal({required this.movie, required this.n, required this.ident});
  @override
  State<Personal> createState() =>
      _PersonalState(this.movie, this.n, this.ident);
}

class _PersonalState extends State<Personal> {
  List movie = [];
  int n;
  int ident;

  _PersonalState(this.movie, this.n, this.ident);
  // void initState() {
  //   super.initState();
  //   Player(
  //     id: movie,
  //     ident: ident,
  //     index: n,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500' + movie[n]['poster_path'],
                ))),
        child: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 1,
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        movie[n]['poster_path'],
                                  ))),
                          height: 250,
                          width: 190,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Rating :' +
                                    movie[n]["vote_average"].toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellowAccent,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 120,
                            height: 60,
                            child: Text(
                                'Released Date :' +
                                    (movie[n]["release_date"] == null
                                        ? movie[n]["first_air_date"].toString()
                                        : movie[n]["release_date"].toString()),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Card(
                      elevation: 2,
                      color: Colors.transparent,
                      margin: EdgeInsets.all(20),
                      child: Text(
                        'About :',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      child: Text(movie[n]["overview"].toString(),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w400)),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.all(20),
                      child: Text(
                        'Trailer',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      color: Colors.transparent,
                    ),
                  ),
                  Player(
                    id: movie,
                    ident: ident,
                    index: n,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
