import 'package:equatable/equatable.dart';

abstract class CoinPriceEvent extends Equatable {
  const CoinPriceEvent();

  @override
  List<Object> get props => [];
}

class Start extends CoinPriceEvent {
  final double coinPrice;

  Start(this.coinPrice);
}

class UpdateCoinPrice extends CoinPriceEvent {
  final double coinPrice;

  UpdateCoinPrice(this.coinPrice);
}
