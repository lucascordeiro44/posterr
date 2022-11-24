import 'package:flutter/material.dart';
import 'package:posterr/core/styles.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';

class AppModalBottomSheet extends StatefulWidget {
  final Key formKey;
  final bool isQuotePost;
  final TextEditingController textController;
  final Post? post;
  final Function() onClickSendPost;
  final Function(Post post) onClickQuotePost;
  const AppModalBottomSheet(
      {this.post,
      required this.onClickSendPost,
      required this.onClickQuotePost,
      required this.textController,
      required this.isQuotePost,
      required this.formKey,
      super.key});

  @override
  State<AppModalBottomSheet> createState() => _AppModalBottomSheetState();
}

class _AppModalBottomSheetState extends State<AppModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    widget.isQuotePost ? 'Write a Quote Post' : 'Write a Post',
                    style: titleStyle,
                  ),
                ),
                _sendButton(widget.post, widget.isQuotePost),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: widget.isQuotePost ? 1 : 4,
                maxLines: widget.isQuotePost ? 3 : 6,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  filled: true,
                  hintText: widget.isQuotePost ? 'Add comment' : 'write a text',
                  fillColor: Colors.blueAccent.withOpacity(0.2),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                ),
                controller: widget.textController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                maxLength: 777,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sendButton(Post? post, bool isQuotePost) {
    return ElevatedButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.blue)))),
      onPressed: () async {
        if (post != null && isQuotePost) {
          Navigator.pop(context);
          widget.onClickQuotePost(post);
        } else {
          Navigator.pop(context);
          widget.onClickSendPost();
        }
      },
      child: Text(isQuotePost ? 'SEND QUOTE' : "SEND POST",
          style: const TextStyle(fontSize: 14)),
    );
  }
}
