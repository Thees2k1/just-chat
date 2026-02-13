part of 'typing_indicator_feature.dart';

class StatusBubble extends StatelessWidget {
  const StatusBubble({
    super.key,
    required this.repeatingController,
    required this.dotIntervals,
    required this.flashingCircleBrightColor,
    required this.flashingCircleDarkColor,
    required this.bubbleColor,
  });

  final List<Interval> dotIntervals;
  final Color flashingCircleDarkColor;
  final Color flashingCircleBrightColor;
  final Color bubbleColor;
  final AnimationController repeatingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        color: bubbleColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var i = 0; i < 3; i++)
            FlashingCircle(
              key: Key("flashing_circle_$i"),
              index: i,
              repeatingController: repeatingController,
              dotIntervals: dotIntervals,
              flashingCircleDarkColor: flashingCircleDarkColor,
              flashingCircleBrightColor: flashingCircleBrightColor,
            ),
        ],
      ),
    );
  }
}
