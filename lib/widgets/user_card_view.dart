import 'package:code_companion/theme.dart';
import 'package:flutter/material.dart';

import '../models/users/result.dart';

class UserCardView extends StatefulWidget {
  UserCardView({Key? key, required this.user}) : super(key: key);
  User user;

  @override
  State<UserCardView> createState() => _UserCardViewState();
}

class _UserCardViewState extends State<UserCardView> {
  @override
  Widget build(BuildContext context) {
    // var ref = widget;
    return Row(children: [
      const Expanded(
        flex: 2,
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(image: AssetImage('images/code-forces.png'))),
      ),
      Expanded(
        flex: 9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // color: Colors.red,
            Text(
              widget.user.handle as String,
              // maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                // Utils.getTime(widget.user as int),
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
            onTap: () {
              // Add2Calendar.addEvent2Cal(Utils.addToCalendar(widget.user));
            },
            child: const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.iconColor,
            ),
          ),
        ),
      ),
    ]);
  }
}
