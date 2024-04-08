import 'dart:convert';

import 'Exercise.dart';
WorkoutPlan workoutFromJson(String str) => WorkoutPlan.fromJson(json.decode(str));

String workoutToJson(WorkoutPlan data) => json.encode(data.toJson());

class WorkoutPlan {
  String nameWorkout;
  List<Exercise> plan;

  WorkoutPlan({required this.nameWorkout, required this.plan});

  factory WorkoutPlan.fromJson(Map<String, dynamic> json) {
    return WorkoutPlan(
      nameWorkout: json["nameWorkout"],
      plan: List<Exercise>.from(json["plan"].map((x) => Exercise.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "nameWorkout": nameWorkout,
    "plan": List<dynamic>.from(plan.map((x) => x.toJson())),
  };
}