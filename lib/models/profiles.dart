import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    required this.status,
    this.result,
  });

  String status;
  List<ResultProfile>? result;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        status: json["status"],
        result: List<ResultProfile>.from(
            json["result"].map((x) => ResultProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class ResultProfile {
  ResultProfile({
    this.lastName,
    this.country,
    this.lastOnlineTimeSeconds,
    this.city,
    this.rating,
    this.friendOfCount,
    this.titlePhoto,
    this.handle,
    this.avatar,
    this.firstName,
    this.contribution,
    this.organization,
    this.rank,
    this.maxRating,
    this.registrationTimeSeconds,
    this.email,
    this.maxRank,
  });

  String? lastName;
  String? country;
  int? lastOnlineTimeSeconds;
  String? city;
  int? rating;
  int? friendOfCount;
  String? titlePhoto;
  String? handle;
  String? avatar;
  String? firstName;
  int? contribution;
  String? organization;
  String? rank;
  int? maxRating;
  int? registrationTimeSeconds;
  String? email;
  String? maxRank;

  factory ResultProfile.fromJson(Map<String, dynamic> json) => ResultProfile(
        lastName: json["lastName"],
        country: json["country"],
        lastOnlineTimeSeconds: json["lastOnlineTimeSeconds"],
        city: json["city"],
        rating: json["rating"],
        friendOfCount: json["friendOfCount"],
        titlePhoto: json["titlePhoto"],
        handle: json["handle"],
        avatar: json["avatar"],
        firstName: json["firstName"],
        contribution: json["contribution"],
        organization: json["organization"],
        rank: json["rank"],
        maxRating: json["maxRating"],
        registrationTimeSeconds: json["registrationTimeSeconds"],
        email: json["email"],
        maxRank: json["maxRank"],
      );

  Map<String, dynamic> toJson() => {
        "lastName": lastName,
        "country": country,
        "lastOnlineTimeSeconds": lastOnlineTimeSeconds,
        "city": city,
        "rating": rating,
        "friendOfCount": friendOfCount,
        "titlePhoto": titlePhoto,
        "handle": handle,
        "avatar": avatar,
        "firstName": firstName,
        "contribution": contribution,
        "organization": organization,
        "rank": rank,
        "maxRating": maxRating,
        "registrationTimeSeconds": registrationTimeSeconds,
        "email": email,
        "maxRank": maxRank,
      };
}
