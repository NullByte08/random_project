import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_project/models/application_model.dart';
import 'package:random_project/models/random_api_response_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<OneJSONModel>> list;
  late List<OneJSONModel> listOfOJM;
  bool initializedOnce = false;
  bool apiCalledOnce = false;

  @override
  Widget build(BuildContext context) {
    if(!apiCalledOnce){
      apiCalledOnce = true;
      list = Provider.of<ApplicationModel>(context,listen: false).getResponse();
    }

    return LayoutBuilder(
      builder: (context,constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;
        return Scaffold(
          appBar: AppBar(
            title: Text("Album List"),
            centerTitle: true,
          ),
          body: SafeArea(
            child:FutureBuilder<List<OneJSONModel>>(
              future: list,
              builder: (context, snapshot) {
                if(snapshot.connectionState== ConnectionState.done && snapshot.data!=null && !snapshot.hasError){
                  if(!initializedOnce){
                    initializedOnce = true;
                    listOfOJM = snapshot.data!;
                  }
                  return ListView.separated(
                    itemCount: listOfOJM.length,
                    itemBuilder: (context, index){
                      return ListTileRandomAPI(screenHeight: screenHeight, screenWidth: screenWidth, text: listOfOJM[index].title);
                    }, separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        thickness: 2,
                      );
                  },
                  );
                }
                else if(snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()),);
                }
                else{
                  return const Center(child: CircularProgressIndicator());
                }
              }
            ),
          ),
        );
      }
    );
  }
}


class ListTileRandomAPI extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final String text;
  const ListTileRandomAPI({Key? key,
  required this.screenHeight,required this.screenWidth,required this.text}) : super(key: key);

  @override
  _ListTileRandomAPIState createState() => _ListTileRandomAPIState();
}

class _ListTileRandomAPIState extends State<ListTileRandomAPI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth,
      height: widget.screenHeight*0.1,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(

        children: [
          Container(
            width: widget.screenWidth*0.2,
            height: widget.screenHeight*0.06,
            color: Colors.blue,
          ),
          const SizedBox(width: 20,),
          Flexible(child: Text(widget.text)),
        ],
      ),
    );
  }
}
