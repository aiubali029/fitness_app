import 'package:fitness_app/api_service/api_service.dart';
import 'package:fitness_app/model/excercise_model.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier{

  List<ExerciseModel> allData = [];

  Future<List<ExerciseModel>> getHomeData(){
    return ApiService().fetchData();
  }

}