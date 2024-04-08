
import 'dart:convert';

ExerciseSet workoutFromJson(String str) => ExerciseSet.fromJson(json.decode(str));

String workoutToJson(ExerciseSet data) => json.encode(data.toJson());

class ExerciseSet {
  int time;
  int rep;
  int weight;
  int rest;

  ExerciseSet({
    required this.time,
    required this.rep,
    required this.weight,
    required this.rest,
  });

  factory ExerciseSet.fromJson(Map<String, dynamic> json) {
    return ExerciseSet(
      time: json["time"],
      rep: json["rep"],
      weight: json["weight"],
      rest: json["rest"],
    );
  }

  Map<String, dynamic> toJson() => {
    "time": time,
    "rep": rep,
    "weight": weight,
    "rest": rest,
  };
}