import 'package:academia/componentes/exercises.dart';
import 'package:academia/componentes/square.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Exercises extends StatefulWidget {
  Exercises({super.key});

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  void showMoreInfo(ExercisesItens exercise) {
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

  List<ExercisesItens> exerciseRecords = [];

  @override
  void initState() {
    super.initState();
    fetchRecords();
  }

  fetchRecords() async {
    var records =
        await FirebaseFirestore.instance.collection('exercises').get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _list = records.docs
        .map(
          (e) => ExercisesItens(
            eid: e.id,
            equipment: e['equipment'],
            imgId: e['imgId'],
            name: e['name'],
            primaryGroup: e['primaryGroup'],
            secondaryGroup: e['secondaryGroup'],
            obs: e['obs'],
          ),
        )
        .toList();
    setState(() {
      exerciseRecords = _list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: exerciseRecords.length,
      itemBuilder: (context, index) {
        return MySquare(
          onTap: () => showMoreInfo(exerciseRecords[index]),
          image: Image.network(
            exerciseRecords[index].imgId,
            fit: BoxFit.cover,
          ),
          name: exerciseRecords[index].name,
          equipment: exerciseRecords[index].equipment,
          primaryGroup: exerciseRecords[index].primaryGroup,
          secondaryGroup: exerciseRecords[index].secondaryGroup,
        );
      },
    ));
  }
}
