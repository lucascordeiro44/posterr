// import 'package:flutter/material.dart';
// import 'package:posterr/core/styles.dart';
// import 'package:posterr/core/widgets/circle_avatar.dart';
// import 'package:posterr/core/widgets/divider.dart';
// import 'package:posterr/modules/post/domain/entities/repost.dart';

// class AppCardQuotePost extends StatelessWidget {
//   final Repost repost;
//   const AppCardQuotePost({super.key, required this.repost});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             const Text(
//               "Repost By: ",
//               style: TextStyle(
//                 color: Colors.grey,
//               ),
//             ),
//             ListTile(
//               leading: AppCircleAvatar(
//                 maxRadius: 35,
//                 minRadius: 30,
//                 photo: repost.assignedToUser.single.photo,
//               ),
//               title: Text(
//                 repost.assignedToUser.single.fullName,
//                 style: subtitleStyle,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: AppDivider(color: Colors.black12),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: AppCircleAvatar(
//                       maxRadius: 24,
//                       minRadius: 20,
//                       photo:
//                           repost.relatedPost.single.assignedToUser.single.photo,
//                     ),
//                     title: Text(
//                       repost.relatedPost.single.assignedToUser.single.fullName,
//                       style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: AppDivider(color: Colors.black12),
//                   ),
//                   ListTile(
//                     title: Text(repost.relatedPost.single.title),
//                     subtitle: Text(repost.relatedPost.single.text),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
