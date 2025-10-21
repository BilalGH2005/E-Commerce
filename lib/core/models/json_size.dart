import 'package:freezed_annotation/freezed_annotation.dart';

part 'json_size.g.dart';

@JsonSerializable()
class JsonSize {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;

  JsonSize({required this.id, required this.name});

  factory JsonSize.fromJson(Map<String, dynamic> json) =>
      _$JsonSizeFromJson(json);

  Map<String, dynamic> toJson() => _$JsonSizeToJson(this);
}
