import 'package:hive/hive.dart';

part 'user_model.g.dart'; // auto-generated

@HiveType(typeId: 0)
class HiveUser extends HiveObject {
  @HiveField(0)
  String uid;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String photoUrl;

  HiveUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
  });
}
