import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:midterm_proj/boxes.dart';
import 'package:midterm_proj/models/model.dart';
import 'package:midterm_proj/widget/goals_dialog.dart';

class GoalsPage extends StatefulWidget {
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Last Time'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<Goals>>(
          valueListenable: Boxes.getGoals().listenable(),
          builder: (context, box, _) {
            final goals = box.values.toList().cast<Goals>();

            return buildContent(goals);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => GoalDialog(
              onClickedDone: addGoal,
            ),
          ),
        ),
      );

  Widget buildContent(List<Goals> goals) {
    if (goals.isEmpty) {
      return Center(
          child: Image.network(
        'https://image.flaticon.com/icons/png/512/2748/2748558.png',
        width: 200,
        height: 200,
      ));
    } 
    else {
      // final netExpense = goals.fold<double>(
      //   0,
      //   (previousValue, goal) => goal.isExpense
      //       ? previousValue - goal.amount
      //       : previousValue + goal.amount,
      // );
      // final newExpenseString = '\$${netExpense.toStringAsFixed(2)}';
      // final color = netExpense > 0 ? Colors.green : Colors.red;

      return Column(
        children: [
          SizedBox(height: 24),
          Text(
            // 'Net Expense: $newExpenseString',
            'You have goal to do',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              // color: color,
            ),
          ),
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: goals.length,
              itemBuilder: (BuildContext context, int index) {
                final goal = goals[index];

                return buildGoal(context, goal);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildGoal(
    BuildContext context,
    Goals goal,
  ) {
    // final color = goal.isExpense ? Colors.red : Colors.green;
    final date = DateFormat.yMMMd().format(goal.createdDate);
    // final amount = '\$' + goal.amount.toStringAsFixed(2);

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          goal.name,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(date),
        // trailing: Text(
        //   category,
        //   style: TextStyle(
        //       color: color, fontWeight: FontWeight.bold, fontSize: 16),
        // ),
        children: [
          buildButtons(context, goal),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Goals goal) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: Text('Done !'),
              icon: Icon(Icons.done),
              onPressed: () => deleteGoal(goal),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Edit'),
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GoalDialog(
                    goal: goal,
                    onClickedDone: (name, category, isExpense) =>
                        editGoal(goal, name, category, isExpense),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: Text('Delete'),
              icon: Icon(Icons.delete),
              onPressed: () => deleteGoal(goal),
            ),
          ),
        ],
      );

  Future addGoal(String name, String category, bool isExpense) async {
    final goal = Goals()
      ..name = name
      ..createdDate = DateTime.now();
      // ..category = category;
      // ..isExpense = isExpense;

    final box = Boxes.getGoals();
    box.add(goal);
    //box.put('mykey', transaction);

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  void editGoal(
    Goals goal,
    String name,
    String category,
    bool isExpense,
  ) {
    goal.name = name;
    // goal.category = category;
    // goal.isExpense = isExpense;

    // final box = Boxes.getTransactions();
    // box.put(transaction.key, transaction);

    goal.save();
  }

  void deleteGoal(Goals goal) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);

    goal.delete();
    //setState(() => transactions.remove(transaction));
  }
}
