import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/model/excercise_model.dart';
import 'package:fitness_app/second_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String link =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR2gsu4SRvRRFkHK8JPTWHZXmaNP0dtpOG6h7ep4zQp7WaamX5S1UaSrc3A";

  List<ExcerciseModel> allData = [];

  late ExcerciseModel excercise;

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  fetchData() async {
    var response = await http.get(Uri.parse(link));
    // print("Our Data is ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var i in data["exercises"]) {
        excercise = ExcerciseModel(
            id: i["id"],
            title: i["title"],
            thumbnail: i["thumbnail"],
            gif: i["gif"],
            seconds: i["seconds"]);

        setState(() {
          allData.add(excercise);
        });
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: allData.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecondPage(excerciseModel: allData[index],)));
                  },
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: "${allData[index].thumbnail}",
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                          child: Text("${allData[index].title}",style: TextStyle(fontSize: 22,color: Colors.amber),),
                        ))
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
