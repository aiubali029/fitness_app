import 'package:meta/meta.dart';
import 'dart:convert';

class ExerciseModel {
  final String id;
  final String title;
  final String thumbnail;
  final String gif;
  final String seconds;

  ExerciseModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.gif,
    required this.seconds,
  });

  factory ExerciseModel.fromJson(String str) => ExerciseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExerciseModel.fromMap(Map<String, dynamic> json) => ExerciseModel(
    id: json["id"],
    title: json["title"],
    thumbnail: json["thumbnail"],
    gif: json["gif"],
    seconds: json["seconds"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "thumbnail": thumbnail,
    "gif": gif,
    "seconds": seconds,
  };
}
