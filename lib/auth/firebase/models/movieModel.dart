class Movie {
  String? backdropPath;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? title;
  double? voteAverage;
  String? category;
  String? releaseDate;

  Movie({
    this.backdropPath,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.title,
    this.voteAverage,
    this.category,
    this.releaseDate,
  });

  // Converts Firestore document to Movie object
  factory Movie.fromFirestore(Map<String, dynamic> data) {
    return Movie(
      backdropPath: data['backdropPath'],
      originalTitle: data['originalTitle'],
      overview: data['overview'],
      posterPath: data['posterPath'],
      title: data['title'],
      voteAverage: data['voteAverage']?.toDouble(),
      releaseDate: data['releaseDate'],
      category: data['category'],
    );
  }
}

final Map<String, List<Movie>> moviesByCategory = {
  'Sci-Fi': [
    Movie(
      title: 'Inception',
      overview:
          'A thief who enters the dreams of others to steal secrets from their subconscious is given the task of planting an idea in a CEO’s mind.',
      voteAverage: 8.8,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/2/2e/Inception_%282010%29_theatrical_poster.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/2/2e/Inception_%282010%29_theatrical_poster.jpg',
      releaseDate: '2010-07-16',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'The Matrix',
      overview:
          'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.',
      voteAverage: 8.7,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/c/c1/The_Matrix_Poster.jpg/220px-The_Matrix_Poster.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/c/c1/The_Matrix_Poster.jpg/220px-The_Matrix_Poster.jpg',
      releaseDate: '1999-03-31',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'Interstellar',
      overview:
          'A team of explorers travels through a wormhole in space in an attempt to ensure humanity\'s survival.',
      voteAverage: 8.6,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/b/bc/Interstellar_film_poster.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/b/bc/Interstellar_film_poster.jpg',
      releaseDate: '2014-11-07',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'Blade Runner 2049',
      overview:
          'A new blade runner, K, unearths a long-buried secret that has the potential to plunge what\'s left of society into chaos.',
      voteAverage: 8.0,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/9/9b/Blade_Runner_2049_poster.png',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/9/9b/Blade_Runner_2049_poster.png',
      releaseDate: '2017-10-06',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'Star Wars: A New Hope',
      overview:
          'Luke Skywalker joins forces with a smuggler, a Wookiee, and two droids to rescue Princess Leia from the Empire and learn about the Force.',
      voteAverage: 8.6,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/8/87/StarWarsMoviePoster1977.jpg/220px-StarWarsMoviePoster1977.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/8/87/StarWarsMoviePoster1977.jpg/220px-StarWarsMoviePoster1977.jpg',
      releaseDate: '1977-05-25',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'The Terminator',
      overview:
          'A cyborg assassin is sent from the future to kill the mother of the future leader of the resistance.',
      voteAverage: 8.0,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/7/70/Terminator1984movieposter.jpg/220px-Terminator1984movieposter.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/7/70/Terminator1984movieposter.jpg/220px-Terminator1984movieposter.jpg',
      releaseDate: '1984-10-26',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'E.T.the Extra-Terrestrial',
      overview:
          'A troubled child summons the courage to help a stranded alien escape Earth and return to his home planet.',
      voteAverage: 7.8,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/6/66/E_t_the_extra_terrestrial_ver3.jpg/220px-E_t_the_extra_terrestrial_ver3.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/6/66/E_t_the_extra_terrestrial_ver3.jpg/220px-E_t_the_extra_terrestrial_ver3.jpg',
      releaseDate: '1982-06-11',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'The Fifth Element',
      overview:
          ' In the future, a cab driver is tasked with saving the world from an ancient evil by helping a mysterious woman who holds the key to ultimate power.',
      voteAverage: 7.6,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/6/65/Fifth_element_poster_%281997%29.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/6/65/Fifth_element_poster_%281997%29.jpg',
      releaseDate: '1997-05-09',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'The Martian',
      overview:
          'An astronaut is stranded on Mars and must use his ingenuity and spirit to survive while awaiting rescue.',
      voteAverage: 8.0,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/c/cd/The_Martian_film_poster.jpg/220px-The_Martian_film_poster.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/c/cd/The_Martian_film_poster.jpg/220px-The_Martian_film_poster.jpg',
      releaseDate: '2015-10-02',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'A Space Odyssey',
      overview:
          'A voyage to Jupiter with the sentient computer HAL-9000 aboard, after the discovery of an alien monolith on the Moon.',
      voteAverage: 8.3,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/1/11/2001_A_Space_Odyssey_%281968%29.png/220px-2001_A_Space_Odyssey_%281968%29.png',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/1/11/2001_A_Space_Odyssey_%281968%29.png/220px-2001_A_Space_Odyssey_%281968%29.png',
      releaseDate: '1968-04-06',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'Avatar',
      overview:
          'A paraplegic Marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.',
      voteAverage: 7.8,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/d/d6/Avatar_%282009_film%29_poster.jpg/220px-Avatar_%282009_film%29_poster.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/d/d6/Avatar_%282009_film%29_poster.jpg/220px-Avatar_%282009_film%29_poster.jpg',
      releaseDate: '2009-12-18',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'Arrival',
      overview:
          'A linguist works with the military to communicate with alien lifeforms after twelve mysterious spacecraft land around the world.',
      voteAverage: 7.9,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/d/df/Arrival%2C_Movie_Poster.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/d/df/Arrival%2C_Movie_Poster.jpg',
      releaseDate: '2016-11-11',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'Minority Report',
      overview:
          'In a future where crimes are stopped before they happen, a cop is accused of a crime he has yet to commit and must prove his innocence.',
      voteAverage: 7.6,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/4/44/Minority_Report_Poster.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/4/44/Minority_Report_Poster.jpg',
      releaseDate: '2002-06-21',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'District 9',
      overview:
          'An extraterrestrial race forced to live in slum-like conditions on Earth suddenly finds a kindred spirit in a government agent assigned to help them.',
      voteAverage: 7.9,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/d/d7/District_nine_ver2.jpg/220px-District_nine_ver2.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/d/d7/District_nine_ver2.jpg/220px-District_nine_ver2.jpg',
      releaseDate: '2009-08-14',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'The Prestige',
      overview:
          'Two magicians engage in a bitter rivalry, with each trying to outdo the other through increasingly elaborate and dangerous tricks.',
      voteAverage: 8.5,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/d/d2/Prestige_poster.jpg/220px-Prestige_poster.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/d/d2/Prestige_poster.jpg/220px-Prestige_poster.jpg',
      releaseDate: '2006-10-20',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'Moon ',
      overview:
          'A man working alone on a lunar base begins to experience strange occurrences, questioning his own sanity.',
      voteAverage: 7.8,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/a/af/Moon_%282009_film%29.jpg/220px-Moon_%282009_film%29.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/a/af/Moon_%282009_film%29.jpg/220px-Moon_%282009_film%29.jpg',
      releaseDate: '2009-06-12',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'The Island',
      overview:
          'In the future, two clones escape from a facility where they are kept for the purpose of providing organs to wealthy people.',
      voteAverage: 6.8,
      backdropPath:
          'https://media0063.elcinema.com/uploads/_315x420_1ed01d259304ace70254ab399d5c732411610e15a2ba2113e4b26a39aab2cc5f.jpg',
      posterPath:
          'https://media0063.elcinema.com/uploads/_315x420_1ed01d259304ace70254ab399d5c732411610e15a2ba2113e4b26a39aab2cc5f.jpg',
      releaseDate: '2005-07-22',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'Star Trek',
      overview:
          'The brash James T. Kirk is recruited by a time-traveling Spock to stop an evil Romulan from destroying the Federation.',
      voteAverage: 8.0,
      backdropPath:
          'https://m.media-amazon.com/images/M/MV5BMmIyYjI0YzUtOWRiZS00NDJhLThiZTktNDkyYzg4Yjg5YmJmXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      posterPath:
          'https://m.media-amazon.com/images/M/MV5BMmIyYjI0YzUtOWRiZS00NDJhLThiZTktNDkyYzg4Yjg5YmJmXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg',
      releaseDate: '2009-05-08',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'Children of Men',
      overview:
          'In a dystopian future where humans have become infertile, a disillusioned bureaucrat is tasked with protecting a miraculously pregnant woman.',
      voteAverage: 7.9,
      backdropPath:
          'https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p159796_p_v8_be.jpg',
      posterPath:
          'https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p159796_p_v8_be.jpg',
      releaseDate: '2006-12-25',
      category: 'Sci-Fi',
    ),
    Movie(
      title: 'GATTACA',
      overview:
          'In a future society where genetics determine one\'s role in life, a man born without the aid of genetic selection strives to defy the system and pursue his dreams.',
      voteAverage: 7.8,
      backdropPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/d/de/Gattaca_poster.jpg/220px-Gattaca_poster.jpg',
      posterPath:
          'https://upload.wikimedia.org/wikipedia/en/thumb/d/de/Gattaca_poster.jpg/220px-Gattaca_poster.jpg',
      releaseDate: '1997-10-24',
      category: 'Sci-Fi',
    ),
  ],
};
