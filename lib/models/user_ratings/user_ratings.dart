import 'dart:convert';

import 'package:collection/collection.dart';

import 'rating.dart';

class UserRatings {
  final String? status;
  final List<Rating>? rating;

  const UserRatings({this.status, this.rating});

  @override
  String toString() => 'UserRatings(status: $status, result: $rating)';

  factory UserRatings.fromMap(Map<String, dynamic> data) => UserRatings(
        status: data['status'] as String?,
        rating: (data['result'] as List<dynamic>?)
            ?.map((e) => Rating.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'result': rating?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserRatings].
  factory UserRatings.fromJson(String data) {
    return UserRatings.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserRatings] to a JSON string.
  String toJson() => json.encode(toMap());

  UserRatings copyWith({
    String? status,
    List<Rating>? result,
  }) {
    return UserRatings(
      status: status ?? this.status,
      rating: result ?? rating,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserRatings) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => status.hashCode ^ rating.hashCode;
}
