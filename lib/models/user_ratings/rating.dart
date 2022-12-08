import 'dart:convert';

import 'package:collection/collection.dart';

class Rating {
  final int? contestId;
  final String? contestName;
  final String? handle;
  final int? rank;
  final int? ratingUpdateTimeSeconds;
  final int? oldRating;
  final int? newRating;

  const Rating({
    this.contestId,
    this.contestName,
    this.handle,
    this.rank,
    this.ratingUpdateTimeSeconds,
    this.oldRating,
    this.newRating,
  });

  @override
  String toString() {
    return 'Result(contestId: $contestId, contestName: $contestName, handle: $handle, rank: $rank, ratingUpdateTimeSeconds: $ratingUpdateTimeSeconds, oldRating: $oldRating, newRating: $newRating)';
  }

  factory Rating.fromMap(Map<String, dynamic> data) => Rating(
        contestId: data['contestId'] as int?,
        contestName: data['contestName'] as String?,
        handle: data['handle'] as String?,
        rank: data['rank'] as int?,
        ratingUpdateTimeSeconds: data['ratingUpdateTimeSeconds'] as int?,
        oldRating: data['oldRating'] as int?,
        newRating: data['newRating'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'contestId': contestId,
        'contestName': contestName,
        'handle': handle,
        'rank': rank,
        'ratingUpdateTimeSeconds': ratingUpdateTimeSeconds,
        'oldRating': oldRating,
        'newRating': newRating,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Rating].
  factory Rating.fromJson(String data) {
    return Rating.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Rating] to a JSON string.
  String toJson() => json.encode(toMap());

  Rating copyWith({
    int? contestId,
    String? contestName,
    String? handle,
    int? rank,
    int? ratingUpdateTimeSeconds,
    int? oldRating,
    int? newRating,
  }) {
    return Rating(
      contestId: contestId ?? this.contestId,
      contestName: contestName ?? this.contestName,
      handle: handle ?? this.handle,
      rank: rank ?? this.rank,
      ratingUpdateTimeSeconds:
          ratingUpdateTimeSeconds ?? this.ratingUpdateTimeSeconds,
      oldRating: oldRating ?? this.oldRating,
      newRating: newRating ?? this.newRating,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Rating) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      contestId.hashCode ^
      contestName.hashCode ^
      handle.hashCode ^
      rank.hashCode ^
      ratingUpdateTimeSeconds.hashCode ^
      oldRating.hashCode ^
      newRating.hashCode;
}
