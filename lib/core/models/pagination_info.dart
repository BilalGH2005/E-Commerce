import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_info.g.dart';

@JsonSerializable()
class PaginationInfo {
  @JsonKey(name: "current_page")
  final int currentPage;
  @JsonKey(name: "page_size")
  final int pageSize;
  @JsonKey(name: "total_items")
  final int totalItems;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "is_first_page")
  final bool isFirstPage;
  @JsonKey(name: "is_last_page")
  final bool isLastPage;

  PaginationInfo({
    required this.currentPage,
    required this.totalItems,
    required this.pageSize,
    required this.totalPages,
    required this.isFirstPage,
    required this.isLastPage,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationInfoToJson(this);
}
