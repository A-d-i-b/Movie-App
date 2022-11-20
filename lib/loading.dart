import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movies/fetching.dart';
import 'package:movies/player.dart';
import 'player.dart';

class Loading extends StatefulWidget {
  int n;
  List movie = [];
  int ident;
  Loading({required this.n, required this.movie, required this.ident});

  @override
  State<Loading> createState() => _LoadingState(this.n, this.movie, this.ident);
}

class _LoadingState extends State<Loading> {
  int n;
  List movie = [];
  int ident;
  _LoadingState(this.n, this.movie, this.ident);
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Personal(ident: ident, movie: movie, n: n);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.teal,
          size: 100,
        ),
      ),
    );
  }
}
