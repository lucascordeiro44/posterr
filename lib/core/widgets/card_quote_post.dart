import 'package:flutter/material.dart';
import 'package:posterr/core/styles.dart';
import 'package:posterr/core/widgets/circle_avatar.dart';
import 'package:posterr/core/widgets/divider.dart';
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
          children: [
            ListTile(
              leading: AppCircleAvatar(
                maxRadius: 25,
                minRadius: 20,
                photo: quotePost.assignedToUser.single.photo,
              ),
              title: Text(
                quotePost.assignedToUser.single.fullName,
                style: subtitleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: AppDivider(color: Colors.black12),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppCircleAvatar(
                        maxRadius: 14,
                        minRadius: 10,
                        photo: quotePost
                            .relatedPost.single.assignedToUser.single.photo,
                      ),
                      Text(
                        quotePost.relatedPost.single.text,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        quotePost
                            .relatedPost.single.assignedToUser.single.fullName,
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  // ListTile(
                  //   leading: AppCircleAvatar(
                  //     maxRadius: 24,
                  //     minRadius: ,
                  //     photo:
                  //         quotePost.relatedPost.single.assignedToUser.single.photo,
                  //   ),
                  //   title: Text(
                  //     quotePost.relatedPost.single.assignedToUser.single.fullName,
                  //     style: const TextStyle(
                  //         fontSize: 12,
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.w500),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: AppDivider(color: Colors.black12),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      quotePost.relatedPost.single.text,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
