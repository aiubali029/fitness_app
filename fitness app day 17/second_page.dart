import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/model/excercise_model.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key, this.excerciseModel});

  final ExcerciseModel? excerciseModel;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  int second = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        CachedNetworkImage(
          imageUrl: "${widget.excerciseModel!.thumbnail}",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Positioned(
            bottom: 20,
            left: 20,
            right: 25,
            child: SleekCircularSlider(
              min: 3,
              max: 20,
              initialValue: second.toDouble(),
              onChange: (double value) {
                setState(() {
                  second =value.toInt();
                });
              },
            
              innerWidget: (double value) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$second",style: TextStyle(fontSize: 25,color: Colors.white),),

                    ElevatedButton(onPressed: (){



                    }, child: Text("Start",style: _myStyle(),))
                  ],
                );
              },
            )),
      ]),
    );
  }
}

_myStyle(){
  return TextStyle(fontSize: 20,color: Colors.amber,fontWeight: FontWeight.bold);
}