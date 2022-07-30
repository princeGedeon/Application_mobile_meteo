import 'package:flutter/material.dart';

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
  List<String> villes=['Paris',"Bénin","Cotonou"];
  String villeChoisie="";


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
            return ListTile(
              title: Text(villes[index]),
              onTap: (){
                  setState((){
                    villeChoisie=villes[index];
                    Navigator.pop(context);
                  });

              },
            );
          },itemCount: villes.length,),
        ),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text((villeChoisie==null)?"Ville actuel":villeChoisie),
          ],
        ),
      ),

    );
  }
}
