import 'package:flutter/material.dart';
import 'package:posterr/core/widgets/circle_avatar.dart';
import 'package:posterr/core/widgets/divider.dart';
import 'package:posterr/modules/post/domain/entities/repost.dart';
import 'package:posterr/modules/user_profile/domain/entities/user.dart';

class AppCardRepost extends StatelessWidget {
  final User loggedUser;
  final Repost repost;
  const AppCardRepost(
      {super.key, required this.repost, required this.loggedUser});

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
              leading: const Icon(Icons.repeat),
              title: Text(
                _whoReposted(),
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: AppCircleAvatar(
                      photo:
                          repost.relatedPost.single.assignedToUser.single.photo,
                    ),
                    title: Text(
                      repost.relatedPost.single.assignedToUser.single.fullName,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Row(
                    children: [
                      Text(
                        "Posted in ${repost.relatedPost.single.postDate}",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: AppDivider(color: Colors.black12),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      repost.relatedPost.single.text,
                      style: const TextStyle(fontSize: 18),
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

  _whoReposted() {
    final User repostUser = repost.assignedToUser.single;
    return repostUser.username == loggedUser.username
        ? 'You reposted'
        : '${repostUser.fullName} reposted';
  }
}
