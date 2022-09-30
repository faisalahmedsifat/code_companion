import 'dart:convert';

import 'package:collection/collection.dart';

import 'result.dart';

class Users {
  String? status;
  List<User>? users;

  Users({this.status, this.users});

  @override
  String toString() => 'Users(status: $status, result: $users)';

  factory Users.fromMap(Map<String, dynamic> data) => Users(
        status: data['status'] as String?,
        users: (data['result'] as List<dynamic>?)
            ?.map((e) => User.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'status': status,
        'result': users?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Users].
  factory Users.fromJson(String data) {
    return Users.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Users] to a JSON string.
  String toJson() => json.encode(toMap());

  Users copyWith({
    String? status,
    List<User>? result,
  }) {
    return Users(
      status: status ?? this.status,
      users: result ?? users,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Users) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => status.hashCode ^ users.hashCode;
}
