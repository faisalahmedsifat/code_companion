import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_companion/theme.dart';
import 'package:code_companion/views/user_profile_page.dart';
import 'package:flutter/material.dart';

import '../models/users/user.dart';
import '../utils/utils.dart';

class UserCardView extends StatefulWidget {
  UserCardView({Key? key, required this.user}) : super(key: key);
  User user;

  @override
  State<UserCardView> createState() => _UserCardViewState();
}

class _UserCardViewState extends State<UserCardView> {
  Widget userCard() {
    var hasHttp = (widget.user.titlePhoto as String)[0] == 'h';
    return GestureDetector(
      child: Row(children: [
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              // child: Image(image: AssetImage('images/code-forces.png'))),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: hasHttp
                        ? CachedNetworkImageProvider(
                            (widget.user.titlePhoto as String))
                        : CachedNetworkImageProvider(
                            "https:" + (widget.user.titlePhoto as String)),
                    backgroundColor: Colors.white,
                  ),
                  Text(widget.user.rank as String),
                ],
              ),
            )),
        Expanded(
          flex: 11,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.handle as String,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text("last online: " +
                    Utils.getTime(widget.user.lastOnlineTimeSeconds as int)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                child: Text(
                  widget.user.rating.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.calendar_today_outlined,
                color: AppColors.iconColor,
              ),
            ),
          ),
        ),
      ]),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => UserProfilePage(widget.user))));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // var ref = widget;
    return userCard();
  }
}
