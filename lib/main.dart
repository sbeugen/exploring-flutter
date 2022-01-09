import 'package:flutter/material.dart';
import 'package:pokemon_test_app/api/pokemon.dart';
import 'package:pokemon_test_app/components/list_drawer.dart';
import 'package:pokemon_test_app/pages/caught_pokemon_page.dart';
import 'package:pokemon_test_app/pages/random_pokemon_page.dart';
import 'package:pokemon_test_app/persistence/pokemon_database_connector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var pokemonDatabaseConnector = PokemonDatabaseConnector();

  runApp(MyApp(pokemonDatabaseConnector: pokemonDatabaseConnector));
}

class MyApp extends StatefulWidget {
  final PokemonDatabaseConnector pokemonDatabaseConnector;

  const MyApp({Key? key, required this.pokemonDatabaseConnector})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Pokemon> _caughtPokemon = [];
  String _selectedRoute = routingConfig.keys.first;

  static final Map<String, String> routingConfig = {
    'route-random-pokemon': 'Random Pokemon',
    'route-caught-pokemon': "Caught Pokemon"
  };

  @override
  void initState() {
    super.initState();

    widget.pokemonDatabaseConnector
        .getAllPokemon()
        .then((caughtPokemon) => setState(() {
              _caughtPokemon = caughtPokemon;
            }));
  }

  void _addToCaughtPokemon(Pokemon pokemon) {
    widget.pokemonDatabaseConnector.insertPokemon(pokemon);

    setState(() {
      _caughtPokemon = [..._caughtPokemon, pokemon];
    });
  }

  void Function(String) _setSelectedRoute(BuildContext context) =>
      (String routeId) {
        if (routeId != _selectedRoute) {
          setState(() {
            _selectedRoute = routeId;
          });
          Navigator.pushNamed(context, '/$routeId');
        }
      };

  ListDrawer _getListDrawer(BuildContext context) => ListDrawer(
      idValueMap: routingConfig,
      selectedElementId: _selectedRoute,
      onElementClicked: _setSelectedRoute(context));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Flutter Test App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/route-random-pokemon',
      routes: {
        '/route-random-pokemon': (context) => RandomPokemonPage(
              caughtPokemon: _caughtPokemon,
              onCatchPressed: _addToCaughtPokemon,
              drawer: _getListDrawer(context),
            ),
        '/route-caught-pokemon': (context) => CaughtPokemonPage(
              drawer: _getListDrawer(context),
              caughtPokemon: _caughtPokemon,
            ),
      },
    );
  }
}
