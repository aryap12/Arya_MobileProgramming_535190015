import 'package:flutter/material.dart';
import 'package:flutter_application_1/url.dart';
import 'package:flutter_application_1/model.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'dart:convert';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MaterialApp(
    title: "poke app",
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Model> pokelist;
  List<Model> get pokemon => pokelist;
  int num = 0;

  bool isSearching = false;

  getPokemonData() async {
    if (pokelist == null) {
      pokelist = new List<Model>();
    }
    if (num < 152) {
      for (var n = 0; n < 5; n++) {
        num++;
        print('pulling data from pokemon index number ${num.toString()}');

        var pull = await Pokepull.fetchpokemon(num.toString());
        if (pull != null) {
          setState(() {
            pokelist.add(Model.fromJson(pull));
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
        appBar: AppBar(
          title: !isSearching
              ? Text("Pokeapp")
              : TextField(
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintText: "search your pokemon here",
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
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 5.0,
                        childAspectRatio: 1.5),
                    itemCount: pokelist.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  child: new AlertDialog(
                                    backgroundColor: Colors.red,
                                    title: new Text(
                                      "#${pokelist[index].num} ${pokelist[index].name}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(children: [
                                        Image(
                                          image: NetworkImage(
                                              pokelist[index].sprites),
                                        ),
                                        Text(
                                          " Pokemon Height :${pokelist[index].height / 10} meter",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          " Pokemon Weight :${pokelist[index].weight / 10}Kg ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ]),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                          'back',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          pokelist[index].sprites)),
                                ),
                                child: Text(
                                  '#${pokelist[index].num} ${pokelist[index].name}',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ))
                        ]),
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
