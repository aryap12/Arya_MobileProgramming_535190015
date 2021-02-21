import 'package:flutter/material.dart';
import 'package:flutter_application_1/model.dart';

class Detail extends StatelessWidget {
  final Model model;
  const Detail({Key key, this.model}) : super(key: key);

  bodyWidget() => Container();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.red,
          title: Text(
            model.name,
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Card(
          child: Column(
            children: [
              Image(
                image: NetworkImage(model.sprites, scale: 0.5),
              ),
              Row(
                children: [
                  Container(
                    child: Column(
                      children: [],
                    ),
                  ),
                  Text("Pokemon Name : ", style: TextStyle(fontSize: 20)),
                  Text(
                    model.name,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Text(
                "",
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Text("Pokemon Height : ", style: TextStyle(fontSize: 20)),
                  Text(
                    '${model.height / 10} m',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Pokemon Weight : ", style: TextStyle(fontSize: 20)),
                  Text(
                    '${model.weight / 10} kg',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Text(
                "",
                style: TextStyle(fontSize: 20),
              ),
              Container(
                  child: Text(
                "Types : ",
                style: TextStyle(fontSize: 20),
              )),
              //types
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: ListView.builder(
                        itemCount: model.types.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                child: Text(
                                  "-${model.types[index]}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                )
              ]),
              Container(
                  child: Text(
                "Abilities : ",
                style: TextStyle(fontSize: 20),
              )),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: ListView.builder(
                        itemCount: model.abilities.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                child: Text(
                                  "${model.abilities[index]}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                )
              ]),
              Container(
                  child: Text(
                "Moves : ",
                style: TextStyle(fontSize: 20),
              )),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      child: ListView.builder(
                        itemCount: model.moves.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                child: Text(
                                  "-${model.moves[index]}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                )
              ])
            ],
          ),
        ))));
  }
}
