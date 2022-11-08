import 'package:flutter/material.dart';
import 'package:posterr/core/widgets/circle_avatar.dart';
import 'package:posterr/core/widgets/divider.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';

class AppCard extends StatelessWidget {
  final Post post;
  final Function onClickRepost;
  const AppCard({super.key, required this.post, required this.onClickRepost});

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
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.schedule,
                    size: 18,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    post.postDate,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: AppCircleAvatar(
                maxRadius: 35,
                minRadius: 30,
                photo: post.assignedToUser.single.photo,
              ),
              title: Text(
                post.assignedToUser.single.fullName,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: AppDivider(color: Colors.black12),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                post.text,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.reply,
                      color: Colors.blueAccent,
                      size: 20,
                    ),
                    label: const Text(
                      'Quote Post',
                      style: TextStyle(color: Colors.blue, fontSize: 10),
                    )),
                TextButton.icon(
                    onPressed: () {
                      onClickRepost();
                    },
                    icon: const Icon(
                      Icons.forward,
                      color: Colors.blueAccent,
                      size: 20,
                    ),
                    label: const Text(
                      'Repost',
                      style: TextStyle(color: Colors.blue, fontSize: 10),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
