// import 'package:flutter/material.dart';

// class AppBottomSheet extends StatefulWidget {
//   const AppBottomSheet({Key? key}) : super(key: key);

//   @override
//   _AppBottomSheetState createState() => _AppBottomSheetState();
// }

// class _AppBottomSheetState extends State<AppBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Form(
//               key: postStore.formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       const Text(
//                         'Write a Post ',
//                         style: titleStyle,
//                       ),
//                       _sendButton()
//                     ],
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     child: TextFormField(
//                       keyboardType: TextInputType.multiline,
//                       minLines: 4,
//                       maxLines: 6,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.blueAccent.withOpacity(0.2),
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide.none,
//                             borderRadius: BorderRadius.circular(20)),
//                       ),
//                       controller: postStore.textController,
//                       autofocus: true,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter some text';
//                         }
//                         return null;
//                       },
//                       maxLength: 777,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }
// }