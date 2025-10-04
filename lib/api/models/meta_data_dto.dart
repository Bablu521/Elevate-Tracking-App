import 'package:json_annotation/json_annotation.dart';
part 'meta_data_dto.g.dart';

@JsonSerializable()
class MetaDataDTO {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "totalItems")
  final int? totalItems;
  @JsonKey(name: "limit")
  final int? limit;

  MetaDataDTO ({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,
  });

  factory MetaDataDTO.fromJson(Map<String, dynamic> json) {
    return _$MetaDataDTOFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetaDataDTOToJson(this);
  }
}