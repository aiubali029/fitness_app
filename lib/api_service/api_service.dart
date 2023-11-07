import 'package:fitness_app/model/excercise_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService{

  String link = "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR2gsu4SRvRRFkHK8JPTWHZXmaNP0dtpOG6h7ep4zQp7WaamX5S1UaSrc3A";
  Future<List<ExerciseModel>>fetchData() async {
    var response = await http.get(Uri.parse(link));
    // print("Our Data is ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return List<dynamic>.from(data["exercises"]).map((e) => ExerciseModel.fromMap(e)).toList();
      // for (var i in data["exercises"]) {
      //   excercise = ExcerciseModel(
      //       id: i["id"],
      //       title: i["title"],
      //       thumbnail: i["thumbnail"],
      //       gif: i["gif"],
      //       seconds: i["seconds"]);
      //
      //   setState(() {
      //     allData.add(excercise);
      //   });
      // }
    } else {
      return [];
    }
  }

}