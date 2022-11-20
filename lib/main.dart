import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'newhome.dart';

final String apikey = '764c7005ee3f09e27e1b99177e5fafa1';

final String token =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NjRjNzAwNWVlM2YwOWUyN2UxYjk5MTc3ZTVmYWZhMSIsInN1YiI6IjYyYmIzMDJkM2Q0M2UwMTNmNzlmMWIzNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2m-ykCoiZyv5-gqtDgG8Dk9AJ-BIRHC4-ddnZTYf7OE';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
