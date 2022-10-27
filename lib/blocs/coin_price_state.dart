import 'package:equatable/equatable.dart';

class CoinPriceState extends Equatable {
  final double coinPrice;
  const CoinPriceState({required this.coinPrice});

  @override
  List<Object> get props => [coinPrice];

  factory CoinPriceState.start(double coinPrice) {
    return CoinPriceState(
      coinPrice: coinPrice,
    );
  }

  CoinPriceState copyWith({
    double? coinPrice,
  }) {
    return CoinPriceState(
      coinPrice: coinPrice ?? this.coinPrice,
    );
  }
}
