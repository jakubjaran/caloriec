import 'package:caloriec/screens/search_screen.dart';
import 'package:flutter/material.dart';

class SearchDialog extends StatefulWidget {
  const SearchDialog({Key? key}) : super(key: key);

  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final _searchController = TextEditingController();

  void _search() {
    if (_searchController.text != '') {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed(
        SearchScreen.route,
        arguments: _searchController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
            controller: _searchController,
            onSubmitted: (_) {
              _search();
            },
            decoration: const InputDecoration(
              label: Text('Szukany produkt'),
            ),
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.search,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            onPressed: _search,
            icon: const Icon(Icons.search),
            label: const Text('Sprawdź'),
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
