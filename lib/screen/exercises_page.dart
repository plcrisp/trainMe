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
  //show more info

  //Exercises list
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
    exerciseRecords.sort((a, b) => a.primaryGroup.compareTo(b.primaryGroup));
    return Scaffold(
        body: ListView.builder(
      itemCount: exerciseRecords.length,
      itemBuilder: (context, index) {
        return MySquare(
          image: exerciseRecords[index].imgId,
          name: exerciseRecords[index].name,
          equipment: exerciseRecords[index].equipment,
          primaryGroup: exerciseRecords[index].primaryGroup,
          secondaryGroup: exerciseRecords[index].secondaryGroup,
          obs: exerciseRecords[index].obs,
        );
      },
    ));
  }
}
