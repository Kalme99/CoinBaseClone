import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/coin_price_bloc.dart';

import '../blocs/coin_price_event.dart';
import '../blocs/coin_price_state.dart';
import '../model/coin.dart';
import '../model/coin_data.dart';
import '../services/coin_repository.dart';
import '../util/theme.dart';

class CoinPage extends StatefulWidget {
  final Coin coin;
  const CoinPage({required this.coin, Key? key}) : super(key: key);

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  late Future<List<CoinData>> _getCoinHourly;

  late double _coinPrice;

  convertToSpots(List<CoinData> coinData) {
    final List<FlSpot> spots = [];
    double maxPrice = 0.0;
    double minPrice = double.maxFinite;
    double maxTime = 0.0;
    double minTime = double.maxFinite;
    const normalizer = 10000;

    // for loop over coin data
    for (var i = 0; i < coinData.length; i++) {
      final CoinData coin = coinData[i];
      final double price = coin.high.toDouble();
      final double time = coin.time.toDouble() / normalizer;
      if (price > maxPrice) {
        maxPrice = price;
      }
      if (price < minPrice) {
        minPrice = price;
      }
      if (time > maxTime) {
        maxTime = time;
      }
      if (time < minTime) {
        minTime = time;
      }
      spots.add(FlSpot(time, price));
    }
    return [spots, maxPrice, maxTime, minPrice, minTime];
  }

  @override
  void initState() {
    super.initState();
    _getCoinHourly = CoinRepository.getCoinHourlyData(widget.coin.ticker);
    _coinPrice = widget.coin.price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.coin.fullName,
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Text(
                "${widget.coin.fullName} price",
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
              BlocBuilder<CoinPriceBloc, CoinPriceState>(
                builder: (context, state) {
                  return Text(
                    "\$${state.coinPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              FutureBuilder<List<CoinData>>(
                future: _getCoinHourly,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data != null) {
                    final f = convertToSpots(snapshot.data!);
                    return CoinHourlyChart(
                      flspots: f[0],
                      maxPrice: f[1],
                      maxTime: f[2],
                      minPrice: f[3],
                      minTime: f[4],
                      coinInitialPrice: widget.coin.price,
                      // priceCallback: (d) {
                      //   setState(() {
                      //     _coinPrice = d ?? widget.coin.price;
                      //   });
                    );
                  }
                  return const Text("Loading");
                },
              ),
              Text(
                widget.coin.fullName,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.coin.ticker,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.grey.shade300,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Additional information:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Algorithm: ${widget.coin.algorithm}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                "Block number: ${widget.coin.blockNumber.toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                "Block reward: ${widget.coin.blockReward.toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                "Block time: ${widget.coin.blockTime.toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              Text(
                "Max supply: ${widget.coin.maxSupply}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 25,
              ),
              // create a blue button that centers the text and has the entire width of the screen
              ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0))),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 15)),
                    backgroundColor:
                        MaterialStateProperty.all(CoinbaseTheme.color)),
                child: const Text(
                  "Trade",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CoinHourlyChart extends StatefulWidget {
  final List<FlSpot> flspots;
  final double maxPrice;
  final double maxTime;
  final double minPrice;
  final double minTime;
  final double coinInitialPrice;
  // final Function(double?) priceCallback;

  const CoinHourlyChart(
      {required this.flspots,
      required this.maxPrice,
      required this.maxTime,
      required this.minPrice,
      required this.minTime,
      required this.coinInitialPrice,
      Key? key})
      : super(key: key);

  @override
  _CoinHourlyChartState createState() => _CoinHourlyChartState();
}

class _CoinHourlyChartState extends State<CoinHourlyChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: LineChart(
        LineChartData(
          backgroundColor: Colors.transparent,
          gridData: FlGridData(
            show: false,
            drawVerticalLine: true,
            horizontalInterval: 1,
            verticalInterval: 1,
          ),
          lineTouchData: LineTouchData(
            enabled: true,
            touchCallback: (c, cc) {
              context.read<CoinPriceBloc>().add(UpdateCoinPrice(
                  cc?.lineBarSpots?[0].y ?? widget.coinInitialPrice));

              // widget.priceCallback(cc?.lineBarSpots?[0].y);
            },
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.transparent,
              tooltipPadding: const EdgeInsets.all(10),
            ),
          ),
          showingTooltipIndicators: [],
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
              show: true, border: Border.all(color: Colors.white, width: 0)),
          minX: widget.minTime,
          maxX: widget.maxTime,
          minY: widget.minPrice,
          maxY: widget.maxPrice,
          lineBarsData: [
            LineChartBarData(
              spots: widget.flspots,
              isCurved: false,
              color: CoinbaseTheme.color,
              barWidth: 2,
              isStrokeCapRound: false,
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
