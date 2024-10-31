class Review {
  int? userId;
  int? rating;
  String? comment;

  Review({this.userId, this.rating, this.comment});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        userId: json['user_id'] as int?,
        rating: json['rating'] as int?,
        comment: json['comment'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'rating': rating,
        'comment': comment,
      };
}
