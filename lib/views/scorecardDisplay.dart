import 'package:flutter/material.dart';
import 'package:mp2/models/scorecard.dart';
import 'package:provider/provider.dart';
import 'package:mp2/models/dice.dart';

class ScorecardDisplay extends StatelessWidget {
  const ScorecardDisplay(
      {super.key, required ScoreCard scorecard, required Dice dice});

  void pickCategory(BuildContext context, ScoreCategory category,
      ScoreCard scorecard, Dice dice) {
    scorecard.registerScore(category, dice.values);
    dice.clear();
    if (scorecard.completed) {
      displayGameOverDialog(context, scorecard);
    }
  }

  void displayGameOverDialog(BuildContext context, ScoreCard scorecard) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Game Over!',
            style: TextStyle(fontSize: 20),
          ),
          content: Text('Your final score is ${scorecard.total}!'),
          actions: [
            TextButton(
              onPressed: () {
                scorecard.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Play Again', style: TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ScoreCard scorecard = Provider.of<ScoreCard>(context);
    final Dice dice = Provider.of<Dice>(context);

    return Expanded(
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      List.generate(ScoreCategory.values.length ~/ 2, (index) {
                    final category = ScoreCategory.values[index];
                    return GestureDetector(
                      onTap: () {
                        if (dice.rollCounter == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Roll at least once before picking.'),
                            ),
                          );
                        } else {
                          pickCategory(context, category, scorecard, dice);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(
                              child: Text(
                                '${category.name} : ',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 30,
                            margin: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                scorecard[category]?.toString() ?? '',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      (ScoreCategory.values.length ~/ 2 + 1), (index) {
                    final category = ScoreCategory
                        .values[index + (ScoreCategory.values.length ~/ 2)];
                    return GestureDetector(
                      onTap: () {
                        if (dice.rollCounter == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Roll at least once before picking.'),
                            ),
                          );
                        } else {
                          pickCategory(context, category, scorecard, dice);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            height: 50,
                            child: Center(
                              child: Text(
                                '${category.name} : ',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 30,
                            margin: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                scorecard[category]?.toString() ?? '',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Current Total: ${scorecard.total}',
                    style: const TextStyle(fontSize: 20)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
