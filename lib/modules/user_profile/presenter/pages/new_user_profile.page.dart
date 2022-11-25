import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:posterr/core/shared/stores/auth_store.dart';
import 'package:posterr/core/styles.dart';
import 'package:posterr/core/shared/widgets/circle_avatar.dart';

class NewUserProfilePage extends StatefulWidget {
  const NewUserProfilePage({super.key});

  @override
  State<NewUserProfilePage> createState() => _NewUserProfilePageState();
}

class _NewUserProfilePageState extends State<NewUserProfilePage> {
  final AuthStore authStore = Modular.get();

  // CustomScrollView(
  //         slivers: [
  //           SliverPersistentHeader(
  //             delegate: WhatsappAppbar(),
  //             pinned: true,
  //           ),
  //           SliverToBoxAdapter(
  //             child: Column(
  //               children: const [ProfileIconButtons()],
  //             ),
  //           ),
  //           const WhatsappProfileBody()
  //         ],
  //       ),
  //     ),
  //   );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: _header(context),
            pinned: true,
          ),
          // SliverAppBar(
          //   expandedHeight: 250.0,
          //   flexibleSpace: _header(context),
          //   flexibleSpace: FlexibleSpaceBar(
          //     title: const Text('User Profile', textScaleFactor: 1),
          //     background: Container(
          //       color: Colors.blue,
          //     ),
          //   ),
          // ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return ListTile(
                  leading: Container(
                      padding: const EdgeInsets.all(8),
                      width: 100,
                      child: const Placeholder()),
                  title: Text('Place ${index + 1}', textScaleFactor: 2),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }

  _header(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.blueAccent.withOpacity(0.7),
          height: MediaQuery.of(context).size.height / 3.3,
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppCircleAvatar(photo: authStore.getLoggedUser.photo),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 14, bottom: 8),
                      child: Text(authStore.getLoggedUser.fullName,
                          style: titleStyle),
                    ),
                    Text("Joined Date: ${authStore.getLoggedUser.dateJoined}",
                        style: subtitleStyle),
                  ]),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
