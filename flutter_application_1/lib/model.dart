// ignore: unused_import
import 'package:flutter_application_1/url.dart';

class Model {
  int num;
  String name;
  double height;
  double weight;
  String sprites;
  List<String> types;
  List<String> moves;
  List<String> abilities;
  String shiny;

  Model({
    this.num,
    this.name,
    this.types,
    this.height,
    this.weight,
    this.sprites,
    this.moves,
    this.abilities,
    this.shiny,
  });

  factory Model.datafromJson(Map<String, dynamic> json) {
    return Model(
        num: json['id'],
        name: json['name'],
        height: double.parse(json["height"].toString()),
        weight: double.parse(json["weight"].toString()),
        sprites: json['sprites']['front_default']);
  }
  factory Model.detailfromJson(Map<String, dynamic> json) {
    List<String> _abilities = (json['abilities'] as List)
        .map((res) => res['ability']['name'].toString())
        .toList();
    List<String> _moves = (json['moves'] as List)
        .map((data) => data['move']['name'].toString())
        .toList();
    List<String> _types = (json['types'] as List)
        .map((dt) => dt['type']['name'].toString())
        .toList();

    return Model(
        num: json['id'],
        name: json['name'],
        height: double.parse(json["height"].toString()),
        weight: double.parse(json["weight"].toString()),
        sprites: json['sprites']['front_default'],
        shiny: json['sprites']['front_shiny'],
        abilities: _abilities,
        moves: _moves,
        types: _types);
  }
}
