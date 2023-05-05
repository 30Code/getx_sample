import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/tab_entity.g.dart';

@JsonSerializable()
class TabEntity {

	List<TabEntity>? children;
	int? courseId;
	int? id;
	String? name;
	int? order;
	int? parentChapterId;
	bool? userControlSetTop;
	int? visible;
  
  TabEntity();

  factory TabEntity.fromJson(Map<String, dynamic> json) => $TabEntityFromJson(json);

  Map<String, dynamic> toJson() => $TabEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}