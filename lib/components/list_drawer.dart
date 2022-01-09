import 'package:flutter/material.dart';

class ListDrawer extends StatelessWidget {
  final Map<String, String> idValueMap;
  final String selectedElementId;
  final ValueSetter<String> onElementClicked;

  const ListDrawer(
      {Key? key,
      required this.idValueMap,
      required this.selectedElementId,
      required this.onElementClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
      const SizedBox(
        height: 100,
      ),
      SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: idValueMap.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () =>
                      onElementClicked(idValueMap.keys.toList()[index]),
                  child: Container(
                      height: 40,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          idValueMap.entries.toList()[index].value,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: selectedElementId ==
                                      idValueMap.keys.toList()[index]
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      )));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ))
    ]));
  }
}
