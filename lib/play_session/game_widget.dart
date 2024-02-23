import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({Key? key}) : super(key: key);

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  final List<Map<String, List<Map<String, int>>>> cardTexts = [
    {
      'One': [
        {'a': 1},
        {'b': 2},
        {'c': 3},
      ]
    },
    {
      'Two': [
        {'a': 4},
        {'b': 5},
        {'c': 6},
      ]
    },
    {
      'Three': [
        {'a': 7},
        {'b': 8},
        {'c': 9},
      ]
    },
    {
      'Four': [
        {'a': 10},
        {'b': 11},
        {'c': 12},
      ]
    },
    {
      'Five': [
        {'a': 13},
        {'b': 14},
        {'c': 15},
      ]
    }
  ];
  late Map<String, List<Map<String, int>>> currentCardData;

  @override
  void initState() {
    super.initState();
  }

  Map<String, List<Map<String, int>>> _getRandomCardData() {
    Random random = Random();
    return cardTexts[random.nextInt(cardTexts.length)];
  }

  @override
  Widget build(BuildContext context) {
    Color caughtColor = Colors.red;
    currentCardData = _getRandomCardData();

    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.black38,
            child: DragTarget<Map<String, List<Map<String, int>>>>(
              onAccept: (data) {
                setState(() {
                  print(jsonEncode(data)); // Print the data of the dropped card
                });
              },
              builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  color: accepted.isEmpty ? caughtColor : Colors.grey.shade200,
                  child: const Center(
                    child: Text('Drag here'),
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: double.maxFinite,
            color: Colors.black45,
            child: Draggable<Map<String, List<Map<String, int>>>>(
              data: currentCardData,
              onDraggableCanceled: (velocity, offset) {},
              feedback: Container(
                width: 100,
                height: 80,
                color: Colors.amber,
                child: Center(
                  child: Text(
                    currentCardData.keys.first,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              child: Container(
                color: Colors.amberAccent,
                child: Center(
                  child: Text("Drag Me"),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black38,
          ),
        ),
      ],
    );
  }
}
