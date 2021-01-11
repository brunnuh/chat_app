import 'package:chat_app/api.dart';
import 'package:flutter/material.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;



class Home extends StatefulWidget {
  //var data;
  //Home({this.data});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController contentcontroller = TextEditingController();
  Api api = Api();
  List messages = [];
  //Echo echo;
  String id;
  bool connect = false;

  Echo echo =  Echo({
  'broadcaster': 'socket.io',
  'client': IO.io,
  'host' : 'http://f77f4ac30729.ngrok.io',
    //'host' : 'http://10.0.2.2:6001'
  });





  @override
  Widget build(BuildContext context) {
    f(){
      echo.channel("public").listen('.SendMessage', (e){

        setState(() {
          messages.add({"content" : e["message"]["content"], "id" : e["message"]["id"]});
          contentcontroller.clear();
        });
      });
      setState(() {
        id = echo.sockedId().toString();
        connect = true;

      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("id: ${id}"),
        actions: [
          connect ? Icon(Icons.beenhere, color: Colors.green,) : IconButton(icon: Icon(Icons.signal_cellular_connected_no_internet_4_bar), onPressed: f)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(messages[index]["id"]),
                  subtitle: Text(messages[index]["content"]),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: contentcontroller,
              decoration: InputDecoration(
                hintText: "Escreva algo ...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: Colors.cyan,),
                  onPressed: () async {
                    if(connect){
                      await api.sendMessage(contentcontroller.text, echo.sockedId());
                    }else{
                      showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            content: Text("Conecte primeiro"),
                          );
                        }
                      );
                    }
                  },
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
