class MovieReview {
  final String author;
  final String avatarPath;
  final String rating;
  final String content;

  String idMovie = '';

  MovieReview(
    this.author,
    this.avatarPath,
    this.rating,
    this.content,
  );

  factory MovieReview.fromJson(dynamic json) {
    if (json == null) {
      return MovieReview('', '', '', '');
    }

    return MovieReview(json['author'], json['author_details']['avatar_path'],
        json['author_details']['rating'].toString(), json['content']);
  }
}
