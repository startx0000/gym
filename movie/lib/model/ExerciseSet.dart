
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
      time: json["time"]!=null ? json["time"] :0,
      rep: json["rep"]!=null ?json["rep"] :0,
      weight: json["weight"]!=null ? json["weight"] :0,
      rest: json["rest"]!=null ? json["rest"] :0,
    );
  }

  Map<String, dynamic> toJson() => {
    "time": time,
    "rep": rep,
    "weight": weight,
    "rest": rest,
  };

  ExerciseSet clone() {
    return ExerciseSet(
      time: this.time,
      rep: this.rep,
      weight: this.weight,
      rest: this.rest,
    );}
}