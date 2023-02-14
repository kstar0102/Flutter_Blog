import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Localization/t_keys.dart';
import '../../presentation/screens/main_screen.dart';
import '../medal/medal_screen.dart';

enum PollButtons { yes, no, irrelevant, none }

class PollsScreen extends HookConsumerWidget {
  PollsScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<ChartData> data = [];
  final TooltipBehavior _tooltip = TooltipBehavior(enable: true);

  final Color _yesColor = const Color(0xFF9FEB7E);
  final Color _noColor = const Color(0xFFFF5757);
  final Color _irrelevantColor = const Color(0xFF737373);
  final Color _beforeColor = const Color(0xFFF5F5F5);

  final ValueNotifier<PollButtons> _isClicked = ValueNotifier(PollButtons.none);

  @override
  Widget build(BuildContext context, ref) {
    data.clear();
    data.addAll([
      ChartData(
        Container(
          height: 32,
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: Color(0xFF9FEB7E),
          ),
          alignment: Alignment.center,
          child: Text(TKeys.yes.translate(context), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Colors.white)),
        ),
        TKeys.yes.translate(context),
        30,
      ),
      ChartData(
        Container(
          height: 32,
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: Color(0xFFFF5757),
          ),
          alignment: Alignment.center,
          child: Text(TKeys.no.translate(context), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Colors.white)),
        ),
        TKeys.no.translate(context),
        20,
      ),
      ChartData(
        Container(
          height: 32,
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: Color(0xFF5D17EB),
          ),
          alignment: Alignment.center,
          child: Text(TKeys.irrelevant.translate(context), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Colors.white)),
        ),
        TKeys.irrelevant.translate(context),
        40,
      ),
    ]);
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleSpacing: 0,
        leadingWidth: 0,
        title: CustomAppBarTitle(scaffoldKey: _scaffoldKey, index: 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(TKeys.weekly_question.translate(context), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
            const SizedBox(height: 12),
            Text(TKeys.would_you_change_anything.translate(context), style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
            const SizedBox(height: 16),
            ValueListenableBuilder(
              valueListenable: _isClicked,
              builder: (_, isClicked, __) {
                return Row(
                  children: [
                    const SizedBox(width: 44),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _isClicked.value = PollButtons.yes;
                        },
                        child: Container(
                          height: 32,
                          decoration: ShapeDecoration(
                            shape: const StadiumBorder(),
                            color: isClicked == PollButtons.yes ? _yesColor : _beforeColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(TKeys.yes.translate(context),
                              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: isClicked != PollButtons.yes ? Colors.black : Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 22),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _isClicked.value = PollButtons.no;
                        },
                        child: Container(
                          height: 32,
                          decoration: ShapeDecoration(
                            shape: const StadiumBorder(),
                            color: isClicked == PollButtons.no ? _noColor : _beforeColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(TKeys.no.translate(context),
                              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: isClicked != PollButtons.no ? Colors.black : Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 22),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _isClicked.value = PollButtons.irrelevant;
                        },
                        child: Container(
                          height: 32,
                          decoration: ShapeDecoration(
                            shape: const StadiumBorder(),
                            color: isClicked == PollButtons.irrelevant ? _irrelevantColor : _beforeColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(TKeys.irrelevant.translate(context),
                              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: isClicked != PollButtons.irrelevant ? Colors.black : Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 44),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Container(
              height: 250,
              padding: const EdgeInsets.symmetric(horizontal: 44),
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                primaryXAxis: CategoryAxis(
                  majorTickLines: const MajorTickLines(size: 0),
                  majorGridLines: const MajorGridLines(width: 0),
                  axisLine: const AxisLine(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  minimum: 0,
                  maximum: 40,
                  interval: 10,
                  majorTickLines: const MajorTickLines(size: 0),
                  axisLine: const AxisLine(width: 0),
                  labelStyle: const TextStyle(color: Colors.transparent),
                ),
                tooltipBehavior: _tooltip,
                series: <ChartSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: data,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    name: TKeys.votes.translate(context),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    pointColorMapper: (ChartData data, _) {
                      if (data.x.toLowerCase() == TKeys.yes.translate(context).toLowerCase()) {
                        return const Color(0xFF9FEB7E);
                      } else if (data.x.toLowerCase() == TKeys.no.translate(context).toLowerCase()) {
                        return const Color(0xFFFF5757);
                      } else if (data.x.toLowerCase() == TKeys.irrelevant.translate(context).toLowerCase()) {
                        return const Color(0xFF5D17EB);
                      } else {
                        return const Color(0xFF9FEB7E);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('${TKeys.total_voters.translate(context)}3499', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
            const SizedBox(height: 24),
            SvgPicture.asset('assets/images/PollPagePicture.svg', height: 250),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.xWidget, this.x, this.y);

  final Widget xWidget;
  final String x;
  final double y;
}
