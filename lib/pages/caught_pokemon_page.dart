import 'package:flutter/material.dart';
import 'package:pokemon_test_app/api/pokemon.dart';
import 'package:pokemon_test_app/components/list_drawer.dart';

class CaughtPokemonPage extends StatelessWidget {
  final ListDrawer drawer;
  final List<Pokemon> caughtPokemon;

  const CaughtPokemonPage(
      {Key? key, required this.drawer, required this.caughtPokemon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Row getRowForIndex(int index) {
      Iterable<Pokemon> pokemon =
          caughtPokemon.where((element) => element.id == index + 1);

      return pokemon.isNotEmpty
          ? Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '#${index + 1}',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      pokemon.first.capitalizedName,
                      style: Theme.of(context).textTheme.headline4,
                    )),
                Image(
                  image: NetworkImage(pokemon.first.imageUrl),
                  height: 50,
                ),
              ],
            )
          : Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      '#${index + 1} ???',
                      style: Theme.of(context).textTheme.headline4,
                    ))
              ],
            );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Caught Pokemon'),
        ),
        body: caughtPokemon.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) => SizedBox(
                      height: 50,
                      child: getRowForIndex(index),
                    ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 151)
            : const Center(
                child: Text('You have not caught any Pokemon yet!'),
              ),
        drawer: drawer);
  }
}
