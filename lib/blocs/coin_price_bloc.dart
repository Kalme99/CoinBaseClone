import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'coin_price_event.dart';
import 'coin_price_state.dart';

class CoinPriceBloc extends Bloc<CoinPriceEvent, CoinPriceState> {
  CoinPriceBloc() : super(CoinPriceState.start(5.0)) {
    on<Start>((event, emit) => _start(emit, event.coinPrice));
    on<UpdateCoinPrice>((event, emit) => _updatePrice(emit, event.coinPrice));
  }
  Future<CoinPriceState> _start(
      Emitter<CoinPriceState> emit, double coinPrice) async {
    emit(state.copyWith(coinPrice: coinPrice));
    return state;
  }

  Future<CoinPriceState> _updatePrice(
      Emitter<CoinPriceState> emit, double coinPrice) async {
    emit(state.copyWith(coinPrice: coinPrice));
    return state;
  }
}
