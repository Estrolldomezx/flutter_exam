import 'package:hive/hive.dart';
import 'package:midterm_proj/models/model.dart';

class Boxes {
  static Box<Goals> getGoals() =>
      Hive.box<Goals>('goals');
}