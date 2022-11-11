import 'package:flutter/material.dart';
import 'package:posterr/core/styles.dart';
import 'package:posterr/core/widgets/circle_avatar.dart';
import 'package:posterr/modules/post/domain/entities/quote_post.dart';

class AppCardQuotePost extends StatelessWidget {
  final QuotePost quotePost;
  const AppCardQuotePost({super.key, required this.quotePost});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: AppCircleAvatar(
                      photo: quotePost.assignedToUser.single.photo),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  quotePost.assignedToUser.single.fullName,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quotePost.comment,
                    style: commentStyle,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(
                            width: 1.8,
                            color: Colors.blueGrey.withOpacity(0.2))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: AppCircleAvatar(
                                      photo: quotePost.relatedPost.single
                                          .assignedToUser.single.photo),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  quotePost.relatedPost.single.assignedToUser
                                      .single.fullName,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              quotePost.relatedPost.single.text,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
