import 'package:elevate_tracking_app/api/models/responses/driver_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';



part 'profile_info_response_dto.g.dart';

@JsonSerializable()
class ProfileInfoResponseDto extends Equatable {
	final String? message;
	final DriverDto? driver;

	const ProfileInfoResponseDto({this.message, this.driver});

	factory ProfileInfoResponseDto.fromJson(Map<String, dynamic> json) {
		return _$ProfileInfoResponseDtoFromJson(json);
	}

	Map<String, dynamic> toJson() => _$ProfileInfoResponseDtoToJson(this);

	@override
	List<Object?> get props => [message, driver];
}
