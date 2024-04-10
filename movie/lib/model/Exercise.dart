import 'package:movie/model/Workout.dart';

import 'ExerciseSet.dart';
import 'dart:convert';

Exercise workoutFromJson(String str) => Exercise.fromJson(json.decode(str));

String workoutToJson(Exercise data) => json.encode(data.toJson());

class Exercise {
  String nameExercise;
  String name;
  int order;
  List<ExerciseSet> sets;
  int rest;
  int totalTime;
  String status;
  Workout workout;

  Exercise({
    required this.nameExercise,
    required this.name,
    required this.order,
    required this.sets,
    required this.rest,
    required this.totalTime,
    required this.status,
    required this.workout,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      nameExercise: json["nameExercise"],
      name: json["name"],
      order: json["order"],
      sets: json["sets"] != null
          ? List<ExerciseSet>.from(json["sets"].map((x) => ExerciseSet.fromJson(x)))
          : [],
      rest: json["rest"] !=null ? json["rest"] : 0 ,
      totalTime: json["totalTime"]!=null ? json["totalTime"] : 0,
      status: json["status"],
      workout: Workout.fromJson(json["workout"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "nameExercise": nameExercise,
    "name": name,
    "order": order,
    "sets": List<dynamic>.from(sets.map((x) => x.toJson())),
    "rest": rest,
    "totalTime": totalTime,
    "status": status,
    "workout": workout.toJson(),
  };
}