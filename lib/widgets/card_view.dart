import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/contests.dart';
import '../utils/utils.dart';

class CardView extends StatefulWidget {
  CardView({Key? key, required this.result}) : super(key: key);
  Result result;

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(
        flex: 2,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                "https://news.itmo.ru/images/news/big/917925.jpg"),
          ),
        ),
      ),
      Expanded(
        flex: 9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // color: Colors.red,
            Text(
              widget.result.name,
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
                Utils.getTime(widget.result.startTimeSeconds),
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
              Add2Calendar.addEvent2Cal(Utils.addToCalendar(widget.result));
            },
            child: const Icon(
              Icons.calendar_today_outlined,
            ),
          ),
        ),
      ),
    ]);
  }
}
