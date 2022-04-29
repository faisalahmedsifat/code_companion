// To parse this JSON data, do
//
//     final contests = contestsFromJson(jsonString);

import 'dart:convert';

Contests contestsFromJson(String str) => Contests.fromJson(json.decode(str));

String contestsToJson(Contests data) => json.encode(data.toJson());

class Contests {
  Contests({
    required this.status,
    required this.result,
  });

  String status;
  List<Result> result;

  factory Contests.fromJson(Map<String, dynamic> json) => Contests(
        status: json["status"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    required this.name,
    this.type,
    this.phase,
    this.frozen,
    required this.durationSeconds,
    required this.startTimeSeconds,
    this.relativeTimeSeconds,
  });

  int? id;
  String name;
  String? type;
  String? phase;
  bool? frozen;
  int durationSeconds;
  int startTimeSeconds;
  int? relativeTimeSeconds;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        phase: json["phase"],
        frozen: json["frozen"],
        durationSeconds: json["durationSeconds"],
        startTimeSeconds: json["startTimeSeconds"],
        relativeTimeSeconds: json["relativeTimeSeconds"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": typeValues.reverse[type],
        "phase": phaseValues.reverse[phase],
        "frozen": frozen,
        "durationSeconds": durationSeconds,
        "startTimeSeconds": startTimeSeconds,
        "relativeTimeSeconds": relativeTimeSeconds,
      };
}

enum Phase { BEFORE, FINISHED, PENDING_SYSTEM_TEST }

final phaseValues = EnumValues({
  "BEFORE": Phase.BEFORE,
  "FINISHED": Phase.FINISHED,
  "PENDING_SYSTEM_TEST": Phase.PENDING_SYSTEM_TEST
});

enum Type { ICPC, CF, IOI, Null }

final typeValues = EnumValues(
    {"CF": Type.CF, "ICPC": Type.ICPC, "IOI": Type.IOI, "Null": Type.Null});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
