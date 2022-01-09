import 'package:pokemon_test_app/api/pokemon.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PokemonDatabaseConnector {
  static const _pokemonDatabaseName = 'pokemon_database.db';
  static const _caughtPokemonTableName = 'caught_pokemon';

  Future<Database>? _database;

  static final PokemonDatabaseConnector _instance =
      PokemonDatabaseConnector._internal();

  PokemonDatabaseConnector._internal();

  factory PokemonDatabaseConnector() {
    _instance._database ??= _openDatabase();
    return _instance;
  }

  static Future<Database> _openDatabase() async {
    return openDatabase(join(await getDatabasesPath(), _pokemonDatabaseName),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $_caughtPokemonTableName (id INTEGER PRIMARY KEY, name TEXT, imageUrl TEXT)'),
        version: 1);
  }

  Future<void> insertPokemon(Pokemon pokemon) async {
    final db = await _instance._database;

    await db?.insert(_caughtPokemonTableName, pokemon.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Pokemon>> getAllPokemon() async {
    final db = await _instance._database;
    var maps = await db?.query(_caughtPokemonTableName);
    return maps
            ?.map((map) => Pokemon(
                name: map['name'] as String,
                id: map['id'] as int,
                imageUrl: map['imageUrl'] as String))
            .toList() ??
        [];
  }
}
