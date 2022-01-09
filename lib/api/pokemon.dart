import 'dart:convert';
import 'package:http/http.dart' as http;

class Pokemon {
  final String name;
  final int id;
  final String imageUrl;

  Pokemon({required this.name, required this.id, required this.imageUrl});

  String get capitalizedName => "${name[0].toUpperCase()}${name.substring(1)}";

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        name: json['name'] as String,
        id: json['id'] as int,
        imageUrl: json['sprites']['front_default'] as String);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, "imageUrl": imageUrl};
  }
}

Future<Pokemon?> fetchPokemon(int index) async {
  final Uri url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$index");
  var response = await http.get(url);
  if (response.statusCode != 200) {
    return null;
  }
  return Pokemon.fromJson(jsonDecode(response.body));
}
