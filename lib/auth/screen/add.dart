import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nexplore/auth/firebase/models/movieModel.dart';

class Add extends StatefulWidget {
  static String id = 'Add';

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final List<Movie> movies = moviesByCategory['Sci-Fi']!;

  Future<void> addMovieToFirestore(Movie movie) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('movies').add({
      'title': movie.title,
      'overview': movie.overview,
      'posterPath': movie.posterPath,
      'backdropPath': movie.backdropPath,
      'voteAverage': movie.voteAverage,
      'releaseDate': movie.releaseDate,
      'category': movie.category,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movies')),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ListTile(
            leading: Image.network(movie.posterPath!),
            title: Text(movie.title!),
            subtitle: Text(movie.overview!),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => addMovieToFirestore(movie),
            ),
          );
        },
      ),
    );
  }
}
