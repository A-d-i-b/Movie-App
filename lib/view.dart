import 'package:flutter/material.dart';
import 'package:movies/loading.dart';
import 'fetching.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class View extends StatefulWidget {
  List<dynamic> grid = [];
  String url;
  String title;

  View({required this.grid, required this.url, required this.title});

  @override
  State<View> createState() => _ViewState(this.grid, this.url, this.title);
}

class _ViewState extends State<View> {
  List<dynamic> grid = [];
  String url;
  int pagenumber = 1;
  String title;
  List add = [];
  _ViewState(this.grid, this.url, this.title);
  load(int id) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=$apikey&language=en-US'));
    var iddecode = jsonDecode(response.body);
    setState(() {
      add = iddecode["results"];
    });
    return add;
  }

  void loading1(int n) async {
    if (n == 1) {
      http.Response response = await http.get(Uri.parse(url + '&page=1'));
      var decode = jsonDecode(response.body);
      setState(() {
        grid = decode["results"];
        pagenumber = 1;
      });
    } else if (n == 2) {
      http.Response response = await http.get(Uri.parse(url + '&page=2'));
      var decode = jsonDecode(response.body);
      setState(() {
        grid = decode["results"];
        pagenumber = 2;
      });
    } else if (n == 3) {
      http.Response response = await http.get(Uri.parse(url + '&page=3'));
      var decode = jsonDecode(response.body);
      setState(() {
        grid = decode["results"];
        pagenumber = 3;
      });
    }
  }

  Color fun2(int n) {
    if (pagenumber == n) {
      return Colors.white54;
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(title),
      ),
      body: Material(
        color: Color(0xFF1F1F3C),
        child: Column(children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 30),
                  itemCount: grid.length,
                  itemBuilder: (BuildContext context, index) {
                    return Column(
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Personal(
                                            n: index,
                                            movie: grid,
                                            ident: grid[index]
                                                        ['original_title'] ==
                                                    null
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
                                              grid[index]['poster_path'],
                                        ))),
                                height: 150,
                                width: 120,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        Container(
                          child: Text(
                            grid[index]['original_title'] == null
                                ? grid[index]['name']
                                : grid[index]['original_title'],
                            style: GoogleFonts.antic(
                                textStyle: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic)),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
          Divider(
            color: Color(0xffA9E1F9),
            indent: 25,
            endIndent: 25,
          ),
          Container(
              color: Colors.transparent,
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Page:',
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 10,
                    decoration: BoxDecoration(
                      color: fun2(1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () {
                        loading1(1);
                      },
                      child: Text(
                        '1',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 10,
                    decoration: BoxDecoration(
                      color: fun2(2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () {
                        loading1(2);
                      },
                      child: Text(
                        '2',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 10,
                    decoration: BoxDecoration(
                      color: fun2(3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: InkWell(
                      onTap: () {
                        loading1(3);
                      },
                      child: Text(
                        '3',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}
