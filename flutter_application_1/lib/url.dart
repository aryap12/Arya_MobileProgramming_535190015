import 'package:dio/dio.dart';

class Url {
  static String urlapi = "https://pokeapi.co/api/v2/";
  // ignore: unnecessary_brace_in_string_interps
  static String extender = "${urlapi}/pokemon";
}

class Pokepull {
  static Future fetchpokemon(String num) async {
    Dio dio = new Dio();
    // ignore: unnecessary_brace_in_string_interps
    var response = await dio.get(Url.extender + "/${num}",
        options: Options(headers: {"Accept": "application/json"}));

    return response.data;
  }
}
