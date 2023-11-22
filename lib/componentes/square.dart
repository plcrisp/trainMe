import 'package:flutter/material.dart';

class MySquare extends StatelessWidget {
  final String image;
  final String name;
  final String equipment;
  final String primaryGroup;
  final String secondaryGroup;
  final String obs;

  const MySquare({
    super.key,
    required this.image,
    required this.name,
    required this.equipment,
    required this.primaryGroup,
    required this.secondaryGroup,
    required this.obs,
  });

  @override
  Widget build(BuildContext context) {
    void showMoreInfo() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.grey[200],
            title: Text(name, textAlign: TextAlign.center),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(obs),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return GestureDetector(
      onTap: showMoreInfo,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 150,
            color: Colors.grey[200],
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name + ' (' + equipment + ')',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              primaryGroup + ' / ' + secondaryGroup,
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Saiba mais...',
                            style: TextStyle(fontWeight: FontWeight.w200),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
