import 'dart:convert';

import 'package:collection/collection.dart';

class User {
  String? lastName;
  String? country;
  int? lastOnlineTimeSeconds;
  String? city;
  int? rating = 0;
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
  String? maxRank;
  String? email;

  User({
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
    this.maxRank,
    this.email,
  });

  @override
  String toString() {
    return 'Result(lastName: $lastName, country: $country, lastOnlineTimeSeconds: $lastOnlineTimeSeconds, city: $city, rating: $rating, friendOfCount: $friendOfCount, titlePhoto: $titlePhoto, handle: $handle, avatar: $avatar, firstName: $firstName, contribution: $contribution, organization: $organization, rank: $rank, maxRating: $maxRating, registrationTimeSeconds: $registrationTimeSeconds, maxRank: $maxRank, email: $email)';
  }

  factory User.fromMap(Map<String, dynamic> data) => User(
        lastName: data['lastName'] as String?,
        country: data['country'] as String?,
        lastOnlineTimeSeconds: data['lastOnlineTimeSeconds'] as int?,
        city: data['city'] as String?,
        rating: data['rating'] as int,
        friendOfCount: data['friendOfCount'] as int?,
        titlePhoto: data['titlePhoto'] as String?,
        handle: data['handle'] as String?,
        avatar: data['avatar'] as String?,
        firstName: data['firstName'] as String?,
        contribution: data['contribution'] as int?,
        organization: data['organization'] as String?,
        rank: data['rank'] as String?,
        maxRating: data['maxRating'] as int,
        registrationTimeSeconds: data['registrationTimeSeconds'] as int?,
        maxRank: data['maxRank'] as String?,
        email: data['email'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'lastName': lastName,
        'country': country,
        'lastOnlineTimeSeconds': lastOnlineTimeSeconds,
        'city': city,
        'rating': rating,
        'friendOfCount': friendOfCount,
        'titlePhoto': titlePhoto,
        'handle': handle,
        'avatar': avatar,
        'firstName': firstName,
        'contribution': contribution,
        'organization': organization,
        'rank': rank,
        'maxRating': maxRating,
        'registrationTimeSeconds': registrationTimeSeconds,
        'maxRank': maxRank,
        'email': email,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());

  User copyWith({
    String? lastName,
    String? country,
    int? lastOnlineTimeSeconds,
    String? city,
    int rating = 0,
    int? friendOfCount,
    String? titlePhoto,
    String? handle,
    String? avatar,
    String? firstName,
    int? contribution,
    String? organization,
    String? rank,
    int? maxRating,
    int? registrationTimeSeconds,
    String? maxRank,
    String? email,
  }) {
    return User(
      lastName: lastName ?? this.lastName,
      country: country ?? this.country,
      lastOnlineTimeSeconds:
          lastOnlineTimeSeconds ?? this.lastOnlineTimeSeconds,
      city: city ?? this.city,
      rating: rating,
      friendOfCount: friendOfCount ?? this.friendOfCount,
      titlePhoto: titlePhoto ?? this.titlePhoto,
      handle: handle ?? this.handle,
      avatar: avatar ?? this.avatar,
      firstName: firstName ?? this.firstName,
      contribution: contribution ?? this.contribution,
      organization: organization ?? this.organization,
      rank: rank ?? this.rank,
      maxRating: maxRating ?? this.maxRating,
      registrationTimeSeconds:
          registrationTimeSeconds ?? this.registrationTimeSeconds,
      maxRank: maxRank ?? this.maxRank,
      email: email ?? this.email,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      lastName.hashCode ^
      country.hashCode ^
      lastOnlineTimeSeconds.hashCode ^
      city.hashCode ^
      rating.hashCode ^
      friendOfCount.hashCode ^
      titlePhoto.hashCode ^
      handle.hashCode ^
      avatar.hashCode ^
      firstName.hashCode ^
      contribution.hashCode ^
      organization.hashCode ^
      rank.hashCode ^
      maxRating.hashCode ^
      registrationTimeSeconds.hashCode ^
      maxRank.hashCode ^
      email.hashCode;
}
