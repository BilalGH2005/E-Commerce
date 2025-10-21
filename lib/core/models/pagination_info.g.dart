// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationInfo _$PaginationInfoFromJson(Map<String, dynamic> json) =>
    PaginationInfo(
      currentPage: (json['current_page'] as num).toInt(),
      totalItems: (json['total_items'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      isFirstPage: json['is_first_page'] as bool,
      isLastPage: json['is_last_page'] as bool,
    );

Map<String, dynamic> _$PaginationInfoToJson(PaginationInfo instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'page_size': instance.pageSize,
      'total_items': instance.totalItems,
      'total_pages': instance.totalPages,
      'is_first_page': instance.isFirstPage,
      'is_last_page': instance.isLastPage,
    };
