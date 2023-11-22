import 'package:academia/componentes/square.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MySearchDelegate extends SearchDelegate {
  CollectionReference _exercises =
      FirebaseFirestore.instance.collection('exercises');

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
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _exercises.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if ((snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['name']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .isEmpty) &&
                (snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['primaryGroup']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .isEmpty) &&
                (snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['secondaryGroup']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .isEmpty)) {
              return Center(child: Text('Nenhum resultado encontrado'));
            }
            return ListView(
              children: [
                ...snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['name']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .map((e) {
                  return MySquare(
                    onTap: () {},
                    image: Image.network(
                      e['imgId'],
                      fit: BoxFit.cover,
                    ),
                    name: e['name'],
                    equipment: e['equipment'],
                    primaryGroup: e['primaryGroup'],
                    secondaryGroup: e['secondaryGroup'],
                  );
                }),
                ...snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['primaryGroup']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .map((e) {
                  return MySquare(
                    onTap: () {},
                    image: Image.network(
                      e['imgId'],
                      fit: BoxFit.cover,
                    ),
                    name: e['name'],
                    equipment: e['equipment'],
                    primaryGroup: e['primaryGroup'],
                    secondaryGroup: e['secondaryGroup'],
                  );
                }),
                ...snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['secondaryGroup']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .map((e) {
                  return MySquare(
                    onTap: () {},
                    image: Image.network(
                      e['imgId'],
                      fit: BoxFit.cover,
                    ),
                    name: e['name'],
                    equipment: e['equipment'],
                    primaryGroup: e['primaryGroup'],
                    secondaryGroup: e['secondaryGroup'],
                  );
                }),
              ],
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) => FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('exercises')
            .where('name', isGreaterThanOrEqualTo: query)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView(
              children: documents
                  .map((doc) => ListTile(
                        title: Text(doc['name']),
                        onTap: () {
                          query = doc['name'];
                          showResults(context);
                        },
                      ))
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
}
