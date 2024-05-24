import 'package:flutter/material.dart';
import 'package:mp2/models/dice.dart';
import 'package:provider/provider.dart';

class DiceDisplay extends StatelessWidget {
  const DiceDisplay({super.key, required Dice dice});

  @override
  Widget build(BuildContext context) {
    final Dice dice = Provider.of<Dice>(context);

    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => dice.toggleHold(index),
                child: Container(
                  width: 75,
                  height: 75,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: dice.isHeld(index) ? Colors.red : Colors.black,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      dice[index]?.toString() ?? '',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (dice.rollCounter < 3) {
                    dice.roll();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      dice.rollCounter < 3 ? Colors.green : Colors.grey,
                ),
                child: Text(
                  dice.rollCounter < 3
                      ? 'Roll (${dice.rollCounter})'
                      : 'Out of rolls',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
