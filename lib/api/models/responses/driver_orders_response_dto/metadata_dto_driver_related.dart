import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'metadata_dto_driver_related.g.dart';

@JsonSerializable()
class MetadataDtoDriverRelated extends Equatable {
  final int? currentPage;
  final int? totalPages;
  final int? totalItems;
  final int? limit;

  const MetadataDtoDriverRelated({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,
  });

  factory MetadataDtoDriverRelated.fromJson(Map<String, dynamic> json) =>
      _$MetadataDtoDriverRelatedFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataDtoDriverRelatedToJson(this);

  @override
  List<Object?> get props => [currentPage, totalPages, totalItems, limit];
}
