import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {
  List<String> SearchResults = [
    'ex 1',
    'ex 2',
    'ex 3',
    'ex 4',
    'ex 5',
  ];
  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );
  @override
  Widget buildResults(BuildContext context) => Container(
        color: Colors.white,
        child: Center(
          child: Text(
            query,
            style: TextStyle(fontSize: 50),
          ),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions = query.isEmpty
        ? SearchResults
        : SearchResults.where((element) {
            final String lowerCaseQuery = query.toLowerCase();
            final String lowerCaseSuggestion = element.toLowerCase();
            return lowerCaseSuggestion.contains(lowerCaseQuery);
          }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestions[index]),
            onTap: () {
              close(context, suggestions[index]);

              showResults(context);
            },
          );
        });
  }
}
