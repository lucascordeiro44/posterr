import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posterr/modules/post/domain/entities/post.dart';
import 'package:posterr/modules/post/presenter/states/post.state.dart';

import 'store/post.store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostStore postStore = Modular.get();
  @override
  void initState() {
    super.initState();
    postStore.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posterr')),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _configurandoModalBottomSheet(context),
          child: const Icon(Icons.add)),
    );
  }

  void _configurandoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: postStore.formKey,
              child: Column(
                // crossAxisAlignment: WrapCrossAlignment.center,
                // alignment: WrapAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: postStore.textController,
                    autofocus: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    maxLength: 10,
                  ),
                  MaterialButton(
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [
                          Text('Send Post '),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.send,
                            size: 25,
                          ),
                        ],
                      ),
                      onPressed: () async {
                        if (postStore.formKey.currentState!.validate()) {
                          await postStore
                              .createPost(postStore.textController.text);
                          setState(() {
                            postStore.textController.clear();
                          });
                        }
                      }),
                ],
              ),
            ),
          );
        });
  }

  _body(BuildContext context) {
    final store = context.watch<PostStore>();
    final state = store.value;
    if (state is LoadingPostState) {
      return const CircularProgressIndicator();
    }

    if (state is SuccessPostState) {
      if (state.posts.isEmpty) {
        return const Text('Sem Posts');
      }
      return ListView.builder(
        shrinkWrap: true,
        itemCount: state.posts.length,
        itemBuilder: (context, index) {
          Post post = state.posts[index];
          return Column(
            children: [
              ListTile(
                title: Text(post.assignedToUser
                    .firstWhere((e) => e.username == 'lucascordeiro')
                    .fullName),
                subtitle: Text(post.text),
              )
            ],
          );
        },
      );
    }

    if (state is ErrorPostState) {
      return Container(
        color: Colors.white,
        child: Text(state.message),
      );
    }
  }
}
