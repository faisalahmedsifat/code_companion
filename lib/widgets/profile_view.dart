import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_companion/models/profiles.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key? key,
    required this.result,
  }) : super(key: key);
  final ResultProfile result;

  validate(var val) {
    return val != null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SizedBox(
                    height: 170,
                    width: 170,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          validate(result.titlePhoto)
                              ? result.titlePhoto as String
                              : ""),
                    ),
                  ),
                ),
                Text(
                  validate(result.handle) ? result.handle as String : " ",
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (validate(result.firstName) || validate(result.lastName))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Name: ",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        validate(result.firstName)
                            ? (result.firstName as String) + " "
                            : "",
                      ),
                      Text(
                        validate(result.lastName)
                            ? (result.lastName as String)
                            : "",
                      ),
                    ],
                  ),
                ),
              if (validate(result.city) || validate(result.country))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Location: ",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        validate(result.city)
                            ? (result.city as String) + ", "
                            : "",
                      ),
                      Text(
                        validate(result.country)
                            ? (result.country as String)
                            : "",
                      ),
                    ],
                  ),
                ),
              if (validate(result.email))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Email: ",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        validate(result.email) ? result.email as String : "",
                      ),
                    ],
                  ),
                ),
              if (validate(result.rank) || validate(result.maxRank))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Rank: ",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        validate(result.rank)
                            ? result.rank.toString() + " "
                            : "",
                      ),
                      Text(
                        validate(result.maxRank)
                            ? result.maxRank.toString() + " "
                            : "",
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                      const Icon(Icons.arrow_upward, size: 15),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (validate(result.rating) || validate(result.maxRating))
                      const Text(
                        "Rating: ",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    Text(
                      result.rating.toString() + "  ",
                    ),
                    Text(
                      result.maxRating.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                    const Icon(Icons.arrow_upward, size: 15),
                  ],
                ),
              ),
              if (validate(result.organization))
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Organisation: ",
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Text(
                        result.organization ?? "",
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
