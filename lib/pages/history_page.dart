import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:midterm_proj/boxes.dart';
import 'package:midterm_proj/models/model_history.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: ValueListenableBuilder<Box<History>>(
        valueListenable: Boxes.getHistories().listenable(),
        builder: (context, box, _) {
          final histories = box.values.toList().cast<History>();

          return buildContent(histories);
        },
      ),
    );
  }

  Widget buildContent(List<History> histories) {
    if (histories.isEmpty) {
      return Center(
        child: Text(
          'No Histories!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: histories.length,
              itemBuilder: (BuildContext context, int index) {
                final history = histories[index];

                return buildHistory(context, history);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildHistory(
    BuildContext context,
    History history,
  ) {
    final color = Colors.green;

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          history.name,
          maxLines: 2,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        trailing: Text(
          DateFormat('dd-MM-yyyy – kk:mm').format(history.createdDate),
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
