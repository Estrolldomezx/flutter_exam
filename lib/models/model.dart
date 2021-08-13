  
import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class Goals extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late DateTime createdDate;
}