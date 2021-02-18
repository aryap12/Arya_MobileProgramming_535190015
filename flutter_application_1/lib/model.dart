class Model {
  int num;
  String name;
  List<dynamic> types;
  double height;
  double weight;
  String sprites;

  Model(
      {this.num,
      this.name,
      this.types,
      this.height,
      this.weight,
      this.sprites});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
        num: json['id'],
        name: json['name'],
        types: json['types'][0]['type']['name'],
        height: double.parse(json["height"].toString()),
        weight: double.parse(json["weight"].toString()),
        sprites: json['sprites']['front_default']);
  }
}
