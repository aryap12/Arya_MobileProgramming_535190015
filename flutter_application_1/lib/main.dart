import 'package:flutter/material.dart';
import 'package:flutter_application_1/Detail.dart';
import 'package:flutter_application_1/url.dart';
import 'package:flutter_application_1/model.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/search.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "poke app",
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Model> pokelist;
  List<Model> get pokemon => pokelist;
  int num = 0;
  String key;
  bool isSearching = false;
  getPokemonData() async {
    if (pokelist == null) {
      pokelist = new List<Model>();
    }
    if (num < 152) {
      for (var n = 0; n < 151; n++) {
        num++;
        print('pulling data from pokemon index number ${num.toString()}');

        var pull = await Pokepull.fetchpokemon(num.toString());
        if (pull != null) {
          setState(() {
            pokelist.add(Model.detailfromJson(pull));
          });
        }
      }
      print(pokelist.length);
      return pokelist;
    }
  }

  @override
  void initState() {
    super.initState();
    getPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: !isSearching
              ? Text("Pokeapp")
              : TextField(
                  onSubmitted: (value) {
                    setState(() {
                      key = value;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Search(kunci: key)));
                    });
                  },
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: "Enter full name of pokemon, ex: bulbasaur",
                      hintStyle: TextStyle(color: Colors.grey))),
          actions: <Widget>[
            isSearching
                ? IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        this.isSearching = !this.isSearching;
                      });
                    })
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        this.isSearching = !this.isSearching;
                      });
                    },
                  )
          ],
          backgroundColor: Colors.cyan,
        ),
        body: Container(
            child: pokelist.length > 0
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 2,
                        childAspectRatio: 1.5),
                    itemCount: pokelist.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      return Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        margin: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "#${pokelist[index].num} ${pokelist[index].name}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                                )),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detail(
                                                model: pokelist[index],
                                              )));
                                  SizedBox(height: 6.0);
                                },
                                child: Container(
                                  width: 100,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            pokelist[index].sprites),
                                        scale: 0.6,
                                        fit: BoxFit.cover),
                                  ),
                                ))
                          ]),
                        ),
                      );
                    },
                  )
                : Container(
                    child: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ))));
  }
}
