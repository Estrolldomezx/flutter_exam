import 'package:hive/hive.dart';

part 'model_history.g.dart';

@HiveType(typeId: 1)
class History extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late DateTime createdDate;
}