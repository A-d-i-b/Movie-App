import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:movies/loading.dart';
import 'view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'fetching.dart';

const String apikey = '764c7005ee3f09e27e1b99177e5fafa1';
const String token =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NjRjNzAwNWVlM2YwOWUyN2UxYjk5MTc3ZTVmYWZhMSIsInN1YiI6IjYyYmIzMDJkM2Q0M2UwMTNmNzlmMWIzNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2m-ykCoiZyv5-gqtDgG8Dk9AJ-BIRHC4-ddnZTYf7OE';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String url1 =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$apikey&language=en-US';
  String url2 =
      'https://api.themoviedb.org/3/movie/popular?api_key=$apikey&language=en-US';
  String url3 =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=$apikey&language=en-US';
  String url4 =
      'https://api.themoviedb.org/3/tv/popular?api_key=$apikey&language=en-US';
  String url5 =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=$apikey&language=en-US';
  String url6 =
      'https://api.themoviedb.org/3/tv/latest?api_key=$apikey&language=en-US';
  List treanding = [];
  List popular = [];
  List upcoming = [];
  List poshows = [];
  List toshows = [];
  List lashow = [];
  List add = [];

  @override
  void initState() {
    loading();

    super.initState();
  }

  void loading() async {
    // TMDB accesdata = TMDB(ApiKeys(apikey, token),
    //     logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

    http.Response response = await http.get(Uri.parse(url1));
    http.Response response1 = await http.get(Uri.parse(url2));
    http.Response response2 = await http.get(Uri.parse(url3));
    http.Response response3 = await http.get(Uri.parse(url4));
    http.Response response4 = await http.get(Uri.parse(url5));

    var decode2 = jsonDecode(response2.body);
    var decode1 = jsonDecode(response1.body);
    var decode = jsonDecode(response.body);
    var decode3 = jsonDecode(response3.body);
    var decode4 = jsonDecode(response4.body);

    setState(() {
      treanding = decode["results"];
      popular = decode1["results"];
      poshows = decode3["results"];
      toshows = decode4["results"];

      if (decode2["results"] != null) {
        upcoming = decode2["results"];
      }
    });
  }

  Container wigh(List G, String n, String t) {
    return Container(
      alignment: Alignment.centerLeft,
      width: 100,
      height: 100,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => View(
                        grid: G,
                        url: n,
                        title: t,
                      )));
        },
        child: Card(
          elevation: 5,
          margin: EdgeInsets.all(20),
          child: Text(
            t,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }

  Container maincard(List l) {
    return Container(
      height: 270,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: l.length,
          separatorBuilder: (BuildContext context, int index) {
            return Padding(padding: EdgeInsets.all(5));
          },
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Personal(
                                  n: index,
                                  movie: l,
                                  ident: l[index]['original_title'] == null
                                      ? 1
                                      : 2,
                                )));
                  },
                  child: Card(
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
                                    l[index]['poster_path'],
                              ))),
                      height: 190,
                      width: 120,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Container(
                    width: 80,
                    child: Text(
                      l[index]['original_title'] == null
                          ? l[index]['name']
                          : l[index]['original_title'],
                      style: GoogleFonts.antic(
                          textStyle: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic)),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1F3C),
      body: ListView(
        children: [
          wigh(treanding, url1, 'Treanding Movies'),
          maincard(treanding),
          wigh(popular, url2, 'Popular Movies'),
          maincard(popular),
          wigh(upcoming, url3, 'Upcoming Movies'),
          maincard(upcoming),
          wigh(poshows, url4, 'Popular Tv Shows'),
          maincard(poshows),
          wigh(toshows, url5, 'Top Rated Tv Shows'),
          maincard(toshows),
        ],
      ),
    );
  }
}
