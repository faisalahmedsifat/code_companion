import 'dart:convert';

ContestsApiResult contestsFromJson(String str) =>
    ContestsApiResult.fromJson(json.decode(str));

String contestsToJson(ContestsApiResult data) => json.encode(data.toJson());

class ContestsApiResult {
  ContestsApiResult({
    required this.status,
    required this.result,
  });

  String status;
  List<Contest> result;

  factory ContestsApiResult.fromJson(Map<String, dynamic> json) =>
      ContestsApiResult(
        status: json["status"],
        result:
            List<Contest>.from(json["result"].map((x) => Contest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Contest {
  Contest({
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

  factory Contest.fromJson(Map<String, dynamic> json) => Contest(
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
