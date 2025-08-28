// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/common/state_enum.dart';
import 'package:jobbiez/presentation/provider/add_review_provider.dart';
import 'package:jobbiez/presentation/provider/job_detail_provider.dart';
import 'package:jobbiez/presentation/widgets/user_avatar.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  Future<void> _handleAddReview(
    BuildContext context,
    AddReviewProvider provider,
  ) async {
    final rating = provider.rating;
    final review = reviewController.text.trim();

    if (rating == 0) {
      _showToast(context, "Please provide a rating first", false);
      return;
    }

    if (review.isEmpty) {
      _showToast(context, "Review cannot be empty", false);
      return;
    }

    final jobDetailProvider = context.read<JobDetailProvider>();
    final jobId = jobDetailProvider.jobDetail!.id;

    final result = await provider.addJobReview(
      jobId,
      rating,
      review,
      context.read<JobDetailProvider>(),
    );

    if (provider.state == RequestState.Loaded) {
      Navigator.pop(context);
      _showToast(context, result, true);
      reviewController.clear();
    } else {
      _showToast(context, result, false);
    }
  }

  void _showToast(BuildContext context, String message, bool isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobDetailProvider>(
      builder: (context, provider, child) {
        final jobDetail = provider.jobDetail;
        final review = jobDetail!.reviews;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reviews', style: kManropeHeading1.copyWith(fontSize: 18)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      review.averageRating.toString(),
                      style: kManropeHeading1,
                    ),
                    const SizedBox(width: 8),
                    RatingBarIndicator(
                      rating: review.averageRating.toDouble(),
                      itemBuilder:
                          (context, index) =>
                              const Icon(Icons.star, color: Colors.black),
                      itemCount: 5,
                      itemSize: 24,
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${review.totalReviews} reviews',
                      style: kManropeBodyText,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kYellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return Container(
                                width: double.infinity,
                                height: 500,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 32,
                                ),
                                child: Consumer<AddReviewProvider>(
                                  builder: (context, provider, child) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            jobDetail.jobTitle,
                                            style: kManropeHeading1.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const SizedBox(height: 48),
                                        Text(
                                          "Your Rating",
                                          style: kManropeHeading5,
                                        ),
                                        const SizedBox(height: 8),
                                        RatingBar.builder(
                                          initialRating: 0,
                                          minRating: 1,
                                          maxRating: 5,
                                          direction: Axis.horizontal,
                                          itemCount: 5,
                                          itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4,
                                          ),
                                          itemBuilder:
                                              (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                          onRatingUpdate: (rating) {
                                            provider.setRating(rating.toInt());
                                          },
                                          updateOnDrag: true,
                                          glow: false,
                                        ),
                                        const SizedBox(height: 24),
                                        Text(
                                          "Your Review",
                                          style: kManropeHeading5,
                                        ),
                                        const SizedBox(height: 8),
                                        TextField(
                                          controller: reviewController,
                                          keyboardType: TextInputType.text,
                                          maxLines: 4,
                                          decoration: InputDecoration(
                                            hintText: 'Review',
                                            hintStyle: TextStyle(
                                              color: Colors.grey[400],
                                            ),
                                            filled: true,
                                            fillColor: kWhite,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                color: kLightGray,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              _handleAddReview(
                                                context,
                                                provider,
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: kYellow,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                            child: Text(
                                              'Rate This',
                                              style: kManropeHeading5.copyWith(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            },
                          ).whenComplete(() {
                            reviewController.clear();
                          });
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                        ),
                        child: Text(
                          'Rate This',
                          style: kManropeHeading5.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                RatingBreakdown(
                  title: '5',
                  rating: review.ratingBreakdown.fiveStar,
                ),
                const SizedBox(height: 8),
                RatingBreakdown(
                  title: '4',
                  rating: review.ratingBreakdown.fourStar,
                ),
                const SizedBox(height: 8),
                RatingBreakdown(
                  title: '3',
                  rating: review.ratingBreakdown.threeStar,
                ),
                const SizedBox(height: 8),
                RatingBreakdown(
                  title: '2',
                  rating: review.ratingBreakdown.twoStar,
                ),
                const SizedBox(height: 8),
                RatingBreakdown(
                  title: '1',
                  rating: review.ratingBreakdown.oneStar,
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: review.reviewItems.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final reviewItem = review.reviewItems[index];

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserAvatar(
                            fotoProfile: reviewItem.fotoProfile,
                            username: reviewItem.username,
                            radius: 25,
                            state: RequestState.Loaded,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  reviewItem.username,
                                  style: kManropeHeading5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RatingBarIndicator(
                                      rating: reviewItem.rating.toDouble(),
                                      itemBuilder:
                                          (context, index) => const Icon(
                                            Icons.star,
                                            color: Colors.black,
                                          ),
                                      itemCount: 5,
                                      itemSize: 20,
                                      direction: Axis.horizontal,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      reviewItem.rating.toString(),
                                      style: kManropeHeading5,
                                    ),
                                    Spacer(),
                                    Text(
                                      timeAgo(reviewItem.createdAt),
                                      style: kManropeBodyText.copyWith(
                                        fontSize: 14,
                                        color: kDarkGray,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  reviewItem.review,
                                  style: kManropeBodyText,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RatingBreakdown extends StatelessWidget {
  final String title;
  final num rating;

  const RatingBreakdown({super.key, required this.title, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: kManropeBodyText),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 15,
            decoration: BoxDecoration(
              color: kLightGray,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: rating.toDouble() / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kYellow,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(width: 42, child: Text('$rating%', style: kManropeBodyText)),
      ],
    );
  }
}

String timeAgo(String dateString) {
  if (!dateString.endsWith('Z')) {
    dateString = '${dateString}Z';
  }

  final createdAt = DateTime.parse(dateString).toLocal();

  final now = DateTime.now();

  final difference = now.difference(createdAt);

  if (difference.inDays > 0) {
    return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago";
  } else if (difference.inHours > 0) {
    return "${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago";
  } else if (difference.inMinutes > 0) {
    return "${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago";
  } else {
    return "Just now";
  }
}
