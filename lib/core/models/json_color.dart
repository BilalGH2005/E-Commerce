import 'package:freezed_annotation/freezed_annotation.dart';

part 'json_color.g.dart';

@JsonSerializable()
class JsonColor {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "hex_code")
  final String hexCode;

  JsonColor({required this.id, required this.hexCode, required this.name});

  factory JsonColor.fromJson(Map<String, dynamic> json) =>
      _$JsonColorFromJson(json);

  Map<String, dynamic> toJson() => _$JsonColorToJson(this);
}
