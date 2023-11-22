import 'package:academia/componentes/exercises.dart';
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
    void showMoreInfoInResults(ExercisesItens exercise) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.grey[200],
            title: Text(exercise.name, textAlign: TextAlign.center),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      exercise.imgId,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(exercise.obs),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

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
                  ExercisesItens exercise =
                      ExercisesItens.fromJson(e.data() as Map<String, dynamic>);
                  return MySquare(
                    image: e['imgId'],
                    name: e['name'],
                    equipment: e['equipment'],
                    primaryGroup: e['primaryGroup'],
                    secondaryGroup: e['secondaryGroup'],
                    obs: e['obs'],
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
                    image: e['imgId'],
                    name: e['name'],
                    equipment: e['equipment'],
                    primaryGroup: e['primaryGroup'],
                    secondaryGroup: e['secondaryGroup'],
                    obs: e['obs'],
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
                    image: e['imgId'],
                    name: e['name'],
                    equipment: e['equipment'],
                    primaryGroup: e['primaryGroup'],
                    secondaryGroup: e['secondaryGroup'],
                    obs: e['obs'],
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
                  .take(5)
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
