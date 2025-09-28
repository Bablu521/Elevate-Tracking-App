import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_profile_image_response_dto.g.dart';

@JsonSerializable()
class UploadProfileImageResponseDto extends Equatable {
	final String? message;

	const UploadProfileImageResponseDto({this.message});

	factory UploadProfileImageResponseDto.fromJson(Map<String, dynamic> json) {
		return _$UploadProfileImageResponseDtoFromJson(json);
	}

	Map<String, dynamic> toJson() => _$UploadProfileImageResponseDtoToJson(this);

	@override
	List<Object?> get props => [message];
}
