import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/provide/home_provider.dart';
import 'package:fitness_app/screen/second_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<HomeProvider>(context).getHomeData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState ==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SecondPage(excerciseModel: snapshot.data![index],)));
                        },
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: "${snapshot.data?[index].thumbnail}",
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Container(
                                    child: Text("${snapshot.data?[index].title}",style: const TextStyle(fontSize: 22,color: Colors.amber),),
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                });
          }
          return const SizedBox();
      },),
    );
  }
}
