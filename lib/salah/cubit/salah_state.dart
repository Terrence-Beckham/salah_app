part of 'salah_cubit.dart';

enum SalahStatus { initial, loading, success, failure }

extension SalahStatusX on SalahStatus {
  bool get isInitial => this == SalahStatus.initial;

  bool get isLoading => this == SalahStatus.loading;

  bool get isSuccess => this == SalahStatus.success;

  bool get isFailure => this == SalahStatus.failure;
}

@JsonSerializable()
final class SalahState extends Equatable {
  const SalahState({this.status = SalahStatus.initial, Salah? salah})
      : salah = salah ?? Salah.empty;

  factory SalahState.fromJson(Map<String, dynamic> json) =>
      _$SalahStateFromJson(json);

  final SalahStatus status;
  final Salah salah;

  SalahState copyWith({
    SalahStatus? status,
    Salah? salah,
  }) {
    return SalahState(
      status: status ?? this.status,
      salah: salah ?? this.salah,
    );
  }

  Map<String, dynamic> toJson() => _$SalahStateToJson(this);

  @override
  List<Object?> get props => [status, salah];
}
