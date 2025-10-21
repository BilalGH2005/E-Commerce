// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonColor _$JsonColorFromJson(Map<String, dynamic> json) => JsonColor(
  id: json['id'] as String,
  hexCode: json['hex_code'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$JsonColorToJson(JsonColor instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'hex_code': instance.hexCode,
};
