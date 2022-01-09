import 'package:flutter/material.dart';
import 'package:pokemon_test_app/api/pokemon.dart';
import 'package:pokemon_test_app/components/list_drawer.dart';
import 'dart:math' show Random;

class RandomPokemonPage extends StatefulWidget {
  final List<Pokemon> caughtPokemon;
  final ValueSetter<Pokemon> onCatchPressed;
  final ListDrawer drawer;

  const RandomPokemonPage(
      {Key? key,
      required this.caughtPokemon,
      required this.onCatchPressed,
      required this.drawer})
      : super(key: key);

  @override
  State<RandomPokemonPage> createState() => _RandomPokemonPageState();
}

class _RandomPokemonPageState extends State<RandomPokemonPage> {
  Pokemon? _pokemon;

  void _getRandomPokemon() async {
    int randomIndex = Random().nextInt(151);
    List<Pokemon> maybePokemon = widget.caughtPokemon
        .where((element) => element.id == randomIndex)
        .toList();

    var pokemon = maybePokemon.isNotEmpty
        ? maybePokemon.first
        : await fetchPokemon(randomIndex + 1);

    setState(() {
      _pokemon = pokemon;
    });
  }

  bool wasPokemonCaught() {
    return widget.caughtPokemon
        .where((element) => element.id == _pokemon!.id)
        .isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Random Pokemon'),
        ),
        body: Stack(children: [
          Positioned(
            child: Text(
                'You have caught ${widget.caughtPokemon.length}/151 Pokemon'),
            right: 10,
            top: 10,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Your random Pokemon is:',
                ),
                if (_pokemon != null)
                  Image(
                    image: NetworkImage(_pokemon!.imageUrl),
                    height: 100,
                  ),
                Text(
                  _pokemon != null
                      ? _pokemon!.capitalizedName
                      : 'Click on randomize',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  height: 30,
                ),
                if (_pokemon != null && !wasPokemonCaught())
                  ElevatedButton(
                    onPressed: () => widget.onCatchPressed(_pokemon!),
                    child: const Text('Catch it!'),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                if (_pokemon != null && wasPokemonCaught())
                  Text(
                    'You caught it!',
                    style: Theme.of(context).textTheme.headline5,
                  ),
              ],
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: _getRandomPokemon,
          tooltip: 'Get random Pokemon',
          child: const Icon(Icons.shuffle),
        ),
        drawer: widget.drawer);
  }
}
