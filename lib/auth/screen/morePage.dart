import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexplore/auth/firebase/models/movieModel.dart';
import 'package:nexplore/core/themes/TextStyles.dart';
import 'package:nexplore/features/details/ui/widgets/movie_rating_widget.dart';
import 'package:nexplore/features/details/ui/widgets/overview_section.dart';
import 'package:nexplore/features/details/ui/widgets/title_section.dart';
import 'package:nexplore/gen/assets.gen.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});
  static String id = 'MorePage';

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  int selectedCategoryIndex = 0;
  final List<String> categories = [
    'Action',
    'Romantic',
    'Comedy',
    'Drama',
    'Sci-Fi',
  ];

  late FirebaseFirestore _firestore;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
  }

  // Fetch movies from Firestore based on category and search term
  Stream<List<Movie>> getMoviesByCategoryAndSearch(
      String category, String searchTerm) {
    return _firestore
        .collection('movies')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Movie.fromFirestore(doc.data()))
          .where((movie) =>
              movie.title!.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    String selectedCategory = categories[selectedCategoryIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('NexPlore', style: TextStyles.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Category Selector
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategoryIndex = index;
                      _searchController
                          .clear(); // Clear search on category change
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedCategoryIndex == index
                          ? Colors.blue
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        categories[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Search Bar
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search movies by categories...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {}); // Rebuild UI when search term changes
              },
            ),
          ),

          // Movie List
          Expanded(
            child: StreamBuilder<List<Movie>>(
              stream: getMoviesByCategoryAndSearch(
                  selectedCategory, _searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No movies available.'));
                }

                List<Movie> movies = snapshot.data!;

                // If no movies found, show a message
                if (movies.isEmpty) {
                  return Center(
                      child: Text('No movies found for your search.'));
                }

                return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    Movie movie = movies[index];

                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailsPage(movie: movie),
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Movie Poster
                            Container(
                              height: 128,
                              width: 85,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(movie.backdropPath!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title!,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ), // Space between title and rating
                                Text(
                                  'Rating: ${movie.voteAverage}⭐',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Assets.images.clock.svg(),
                                    SizedBox(
                                      width: 1.5,
                                    ),
                                    Text(
                                      movie.releaseDate!,
                                      style: TextStyles.movieRate,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Spacer(), // Optional: adds space at the end to push the content
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final TextEditingController _commentController = TextEditingController();
  String? currentUsername;
  String? currentUserProfileImage;
  double _rating = 0.0; // Track the rating of the current user

  // Firebase Firestore reference
  late FirebaseFirestore _firestore;

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _getCurrentUser();
  }

  // Function to get current user information (username and profile image)
  Future<void> _getCurrentUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch username and profile image from 'users' collection
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(user.email) // Use the email as the document ID
            .get();

        setState(() {
          currentUsername = userDoc['username'] ?? "Anonymous";
          currentUserProfileImage = userDoc['profile_image'] ??
              'assets/images/profile.png'; // Fallback image
        });
      }
    } catch (e) {
      print("Error fetching current user: $e");
    }
  }

  // Function to post a comment to Firestore with a random document ID
  Future<void> _addComment() async {
    if (_commentController.text.isEmpty ||
        currentUsername == null ||
        _rating == 0.0) {
      return;
    }

    try {
      await _firestore
          .collection('movies')
          .doc(widget.movie.title)
          .collection('comments')
          .add({
        'username': currentUsername,
        'profile_image': currentUserProfileImage,
        'comment': _commentController.text,
        'rating': _rating, // Add rating to the comment
        'timestamp': FieldValue.serverTimestamp(),
      });

      _commentController.clear();
    } catch (e) {
      print("Error adding comment: $e");
    }
  }

  // Stream to fetch the comments for the current movie and calculate average rating
  Stream<List<Comment>> _getComments() {
    return _firestore
        .collection('movies')
        .doc(widget.movie.title)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Comment.fromFirestore(doc.data());
      }).toList();
    });
  }

  // Calculate average rating
  double _calculateAverageRating(List<Comment> comments) {
    double totalRating = 0.0;
    comments.forEach((comment) {
      totalRating += comment.rating ?? 0.0;
    });
    return comments.isEmpty ? 0.0 : totalRating / comments.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 550.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(fit: StackFit.passthrough, children: [
                Image.network(
                  widget.movie.backdropPath!,
                  fit: BoxFit.cover,
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  TitleSection(widget.movie.title!),
                  SizedBox(height: 8),
                  MovieRatingWidget(widget.movie.voteAverage!),
                  SizedBox(height: 16),
                  OverviewSection(widget.movie.overview!),
                  SizedBox(height: 32),

                  // Rating Section
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rate this Movie", style: TextStyles.title),
                        StarRating(
                          rating: _rating,
                          onRatingChanged: (newRating) {
                            setState(() {
                              _rating = newRating;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: "Write a comment...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: _addComment,
                            ),
                          ),
                          maxLines: 3,
                        ),
                        SizedBox(height: 16),
                        Text("Comments", style: TextStyles.title),
                      ],
                    ),
                  ),

                  // Comments List
                  StreamBuilder<List<Comment>>(
                    stream: _getComments(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text("No comments yet."));
                      }

                      List<Comment> comments = snapshot.data!;
                      double averageRating = _calculateAverageRating(comments);

                      return Column(
                        children: [
                          Text(
                            "Average Rating: ${averageRating.toStringAsFixed(1)}⭐",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              Comment comment = comments[index];
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                color: const Color(0xffE8E0F0),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      // CircleAvatar(
                                      //   backgroundImage: NetworkImage(
                                      //     comment.profileImage ??
                                      //         'assets/images/profile.png',
                                      //   ),
                                      // ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              comment.username!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              comment.comment!,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              comment.timestamp != null
                                                  ? comment.timestamp!
                                                      .toDate()
                                                      .toString()
                                                  : 'Timestamp not available',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Comment Model
class Comment {
  final String? username;
  final String? profileImage;
  final String? comment;
  final double? rating; // Add rating field
  final Timestamp? timestamp;

  Comment(
      {this.username,
      this.profileImage,
      this.comment,
      this.rating,
      this.timestamp});

  factory Comment.fromFirestore(Map<String, dynamic> firestoreDoc) {
    return Comment(
      username: firestoreDoc['username'],
      profileImage: firestoreDoc['profile_image'],
      comment: firestoreDoc['comment'],
      rating: firestoreDoc['rating']?.toDouble(), // Retrieve rating
      timestamp: firestoreDoc['timestamp'],
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onRatingChanged;

  const StarRating(
      {super.key, required this.rating, required this.onRatingChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.yellow,
          ),
          onPressed: () => onRatingChanged(index + 1.0),
        );
      }),
    );
  }
}
