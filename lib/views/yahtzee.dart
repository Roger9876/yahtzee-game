import 'package:flutter/material.dart';
import 'package:mp2/models/dice.dart';
import 'package:mp2/models/scorecard.dart';
import 'package:mp2/views/scorecardDisplay.dart';
import 'package:mp2/views/diceDisplay.dart';
import 'package:provider/provider.dart';

class Yahtzee extends StatelessWidget {
  const Yahtzee({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Yahtzee - Single Player Mode',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Colors.white70,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider<Dice>(create: (context) => Dice(5)),
              ChangeNotifierProvider<ScoreCard>(
                  create: (context) => ScoreCard()),
            ],
            child: const Gameplay(),
          ),
        ),
      ),
    );
  }
}

class Gameplay extends StatelessWidget {
  const Gameplay({super.key});

  @override
  Widget build(BuildContext context) {
    final dice = Provider.of<Dice>(context, listen: false);
    final scorecard = Provider.of<ScoreCard>(context, listen: false);

    return Center(
      child: Column(
        children: [
          DiceDisplay(dice: dice),
          const SizedBox(height: 30),
          ScorecardDisplay(scorecard: scorecard, dice: dice),
        ],
      ),
    );
  }
}
