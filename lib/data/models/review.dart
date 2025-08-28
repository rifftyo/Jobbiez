import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final num averageRating;
  final int totalReviews;
  final RatingBreakdown ratingBreakdown;
  final List<ReviewItem> reviewItems;

  const Review({
    required this.averageRating,
    required this.totalReviews,
    required this.ratingBreakdown,
    required this.reviewItems,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      averageRating: json['average_rating'],
      totalReviews: json['total_reviews'],
      ratingBreakdown: RatingBreakdown.fromJson(json['rating_breakdown']),
      reviewItems:
          (json['list'] as List).map((e) => ReviewItem.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [
    averageRating,
    totalReviews,
    ratingBreakdown,
    reviewItems,
  ];
}

class RatingBreakdown extends Equatable {
  final num oneStar;
  final num twoStar;
  final num threeStar;
  final num fourStar;
  final num fiveStar;

  const RatingBreakdown({
    required this.oneStar,
    required this.twoStar,
    required this.threeStar,
    required this.fourStar,
    required this.fiveStar,
  });

  factory RatingBreakdown.fromJson(Map<String, dynamic> json) {
    return RatingBreakdown(
      oneStar: json['1'],
      twoStar: json['2'],
      threeStar: json['3'],
      fourStar: json['4'],
      fiveStar: json['5'],
    );
  }

  @override
  List<Object?> get props => [oneStar, twoStar, threeStar, fourStar, fiveStar];
}

class ReviewItem extends Equatable {
  final String username;
  final String? fotoProfile;
  final int rating;
  final String review;
  final String createdAt;

  const ReviewItem({
    required this.username,
    required this.fotoProfile,
    required this.rating,
    required this.review,
    required this.createdAt,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      username: json['username'],
      fotoProfile: json['foto_profile'],
      rating: json['rating'],
      review: json['review'],
      createdAt: json['created_at'],
    );
  }

  @override
  List<Object?> get props => [username, fotoProfile, rating, review, createdAt];
}
