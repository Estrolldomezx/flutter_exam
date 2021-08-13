import 'package:hive/hive.dart';
import 'package:midterm_proj/models/model.dart';
import 'package:midterm_proj/models/model_history.dart';

class Boxes {
  static Box<Goals> getGoals() => Hive.box<Goals>('goals');
  static Box<History> getHistories() => Hive.box<History>('histories');
}
