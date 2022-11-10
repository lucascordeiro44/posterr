import 'package:flutter/material.dart';
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListTile(
                  leading: AppCircleAvatar(
                      photo: quotePost.assignedToUser.single.photo),
                  title: Text(
                    quotePost.assignedToUser.single.fullName,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
