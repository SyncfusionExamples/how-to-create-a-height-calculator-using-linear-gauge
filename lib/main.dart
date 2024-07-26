import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: HeightCalculator()),
    ),
  );
}

class HeightCalculator extends StatefulWidget {
  const HeightCalculator({super.key});

  @override
  State<HeightCalculator> createState() => _HeightCalculatorState();
}

class _HeightCalculatorState extends State<HeightCalculator> {
  _HeightCalculatorState();
  double _pointerValue = 130;
  final double _maximumLevel = 200;

  List<LinearAxisLabel> _generateLabels() {
    return [
      const LinearAxisLabel(text: '0 cm', value: 0),
      const LinearAxisLabel(text: '25 cm', value: 25),
      const LinearAxisLabel(text: '50 cm', value: 50),
      const LinearAxisLabel(text: '75 cm', value: 75),
      const LinearAxisLabel(text: '100 cm', value: 100),
      const LinearAxisLabel(text: '125 cm', value: 125),
      const LinearAxisLabel(text: '150 cm', value: 150),
      const LinearAxisLabel(text: '175 cm', value: 175),
      const LinearAxisLabel(text: '200 cm', value: 200),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(150),
      child: _buildHeightCalculator(context),
    );
  }

  Widget _buildHeightCalculator(BuildContext context) {
    return SfLinearGauge(
      orientation: LinearGaugeOrientation.vertical,
      maximum: _maximumLevel,
      tickPosition: LinearElementPosition.outside,
      labelPosition: LinearLabelPosition.outside,
      minorTicksPerInterval: 5,
      interval: 25,
      onGenerateLabels: _generateLabels,
      axisTrackStyle: const LinearAxisTrackStyle(color: Color(0xffBC5A94)),
      markerPointers: <LinearMarkerPointer>[
        LinearShapePointer(
          value: _pointerValue,
          enableAnimation: false,
          onChanged: (dynamic value) {
            setState(() {
              _pointerValue = value as double;
            });
          },
          shapeType: LinearShapePointerType.rectangle,
          color: const Color(0xff134B70),
          height: 2,
          width: 350,
        ),
        _buildLinearWidgetPointer(
          value: _pointerValue,
          offset: 0,
          child: SizedBox(
            width: 24,
            height: 16,
            child: Image.asset(
              'asset/rectangle_pointer.png',
              color: const Color(0xff134B70),
            ),
          ),
        ),
        _buildLinearWidgetPointer(
          value: _pointerValue,
          offset: 350,
          position: LinearElementPosition.outside,
          child: Container(
            width: 60,
            height: 25,
            decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '${_pointerValue.toStringAsFixed(0)}cm',
              ),
            ),
          ),
        ),
      ],
      ranges: <LinearGaugeRange>[
        LinearGaugeRange(
          endValue: _pointerValue,
          startWidth: 400,
          midWidth: 400,
          endWidth: 450,
          color: Colors.transparent,
          child: Image.asset(
            width: 30,
            height: 60,
            'asset/person_walking.png',
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    );
  }

  LinearWidgetPointer _buildLinearWidgetPointer({
    required double value,
    required Widget child,
    LinearElementPosition position = LinearElementPosition.cross,
    double offset = 0,
  }) {
    return LinearWidgetPointer(
      value: value,
      enableAnimation: false,
      onChanged: (dynamic value) {
        setState(() {
          _pointerValue = value as double;
        });
      },
      offset: offset,
      position: position,
      child: child,
    );
  }
}
