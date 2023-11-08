import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/provide/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
      ),
      body: FutureBuilder(
        future: Provider.of<HomeProvider>(context).getHomeData(),
        builder: (context, snapshot) {
          if(snapshot.connectionState ==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasData){
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 180,
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(
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
                              ),
                            ),
                            Expanded(
                              child: Text("${snapshot.data?[index].title}")
                            ),
                          ],
                        );
                      }),
                ),
              ],
            );
          }
          return const SizedBox();
        },),
    );
  }
}
