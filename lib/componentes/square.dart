import 'package:flutter/material.dart';

class MySquare extends StatelessWidget {
  final Widget image;
  final String name;
  final String equipment;
  final String primaryGroup;
  final String secondaryGroup;
  final onTap;
  const MySquare({
    super.key,
    required this.image,
    required this.onTap,
    required this.name,
    required this.equipment,
    required this.primaryGroup,
    required this.secondaryGroup,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                      child: image,
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
                          Text(
                            primaryGroup + ' / ' + secondaryGroup,
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
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
