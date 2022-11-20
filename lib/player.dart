import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

const String apikey = '764c7005ee3f09e27e1b99177e5fafa1';

class Player extends StatefulWidget {
  List id;
  int ident;
  int index;
  Player({required this.id, required this.ident, required this.index});
  @override
  State<Player> createState() => _PlayerState(this.id, this.ident, this.index);
}

class _PlayerState extends State<Player> {
  List add = [];
  List id = [];
  int ident;
  int index;

  late String Keyid = add[0]["key"];
  _PlayerState(this.id, this.ident, this.index);
  Future load() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/' +
            id[index]["id"].toString() +
            '/videos?api_key=$apikey&language=en-US'));
    var iddecode = jsonDecode(response.body);
    setState(() {
      add = iddecode["results"];
    });
  }

  Future load1() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/tv/' +
            id[index]["id"].toString() +
            '/videos?api_key=$apikey&language=en-US'));
    var iddecode = jsonDecode(response.body);
    setState(() {
      add = iddecode["results"];
    });
  }

  late YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId:
        YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=$Keyid')!,
    flags: YoutubePlayerFlags(
      autoPlay: false,
    ),
  );
  void initState() {
    ident == 1 ? load1() : load();

    super.initState();
  }

  // @override
  // void deactivate() {
  //   controller.pause();
  //   super.deactivate();
  // }
  //
  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return add != add.isEmpty
        ? Container(
            color: Colors.transparent,
            child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: controller,
              ),
              builder: (context, player) {
                return Container(
                  child: player,
                );
              },
            ),
          )
        : Container(
            child: Text("hello"),
          );
  }
}
