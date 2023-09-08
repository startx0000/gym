// To parse this JSON data, do
//
//     final workout = workoutFromJson(jsonString);

import 'dart:convert';

Workout workoutFromJson(String str) => Workout.fromJson(json.decode(str));

String workoutToJson(Workout data) => json.encode(data.toJson());

class Workout {
  String name;
  String category;
  String video;
  bool weight;
  String level;
  String ?img;
  String description;

  Workout({
    required this.name,
    required this.category,
    required this.video,
    required this.weight,
    required this.level,
    this.img,
    required this.description,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
    name: json["name"],
    category: json["category"],
    video: json["video"],
    weight: json["weight"],
    level: json["level"],
    img: json["img"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "category": category,
    "video": video,
    "weight": weight,
    "level": level,
    "img": img,
    "description": description,
  };
}
