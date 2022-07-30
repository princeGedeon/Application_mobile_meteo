import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ' Prince Meto'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String key="villes";
  List<String> villes=[];
  String villeChoisie="";

  @override
  void initState() {
    // TODO: implement initState
    obtenir();
    print(villes);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
        centerTitle: true,
      ),
      drawer:  Drawer(
        child: Container(
          color: Colors.blue,
          child: ListView.builder(itemBuilder: (context,index){

            if(index==0){
              return DrawerHeader(child: Column(
                children: [
                  textAvecStyle("Mes Villes",fontSize: 20.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white,elevation: 8),
                  onPressed: ajoutVille, child:textAvecStyle("Ajouter une ville",color: Colors.blue), )
                ],
              ));
            }else if (index==1){
              return ListTile(
                trailing: IconButton(icon: Icon(Icons.delete,color: Colors.white,),onPressed: (){
                  suprrimer(villes[index]);
                },),
                title: textAvecStyle("Ma ville actuel"),
                onTap: (){
                  setState((){
                    villeChoisie="";
                    Navigator.pop(context);
                  });
                },
              );

            }else {
              return ListTile(
                title: Text(villes[index-2]),
                onTap: () {
                  setState(() {
                    villeChoisie = villes[index-2];
                    print(villeChoisie);
                    Navigator.pop(context);
                  });
                }

            );
            }}
          ,itemCount: villes.length+2,),
        ),
      ),

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            textAvecStyle((villeChoisie==null)?"Ville actuel":villeChoisie,color: Colors.blue),
          ],
        ),
      ),

    );
  }

  Text textAvecStyle(String data,{color:Colors.white,fontSize:17.0,fontStyle:FontStyle.italic,textAlign:TextAlign.center}){
    return Text(data,style: TextStyle(color: color,fontSize: fontSize,fontStyle: fontStyle),);

  }

  Future<void> ajoutVille() async{
    return  showDialog(barrierDismissible: true,context: context, builder: (BuildContext ctx){
        return SimpleDialog(
          contentPadding: EdgeInsets.all(20),
          title: textAvecStyle("Ajoutez une ville",fontSize: 22.0,color: Colors.blue),
          children: [
            TextField(
              decoration: InputDecoration(labelText: "ville"),
              onSubmitted: (String str){
                ajouter(str);

                Navigator.pop(context);
              }
            )
          ],
        );
    });
  }

  void obtenir() async{
    SharedPreferences sharedpreference=await SharedPreferences.getInstance();
    List<String>? liste=await sharedpreference.getStringList(key);
    if (liste!=null){
      setState((){

        villes=liste;
      });

    }
  }

  void ajouter(String str) async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    villes.add(str);
    await sharedPreferences.setStringList(key, villes);
    obtenir();

  }

  void suprrimer(String str) async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    villes.remove(str);
    await sharedPreferences.setStringList(key, villes);
    obtenir();

  }
}
