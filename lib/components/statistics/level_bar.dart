import 'package:flutter/material.dart';

class LevelBar extends StatefulWidget {
  final int level;
  final int currentXP;
  final int maxXP;

  LevelBar({
    Key? key,
    required this.level,
    required this.currentXP,
    required this.maxXP,
  }) : super(key: key);

  @override
  _LevelBarState createState() => _LevelBarState();
}

class _LevelBarState extends State<LevelBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: widget.currentXP / widget.maxXP)
        .animate(_controller)
      ..addListener(() {
        setState(() {
          _progress = _animation.value;
        });
      });

    _controller.forward();
  }

  @override
  void didUpdateWidget(LevelBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentXP != widget.currentXP) {
      _animation =
          Tween<double>(begin: _progress, end: widget.currentXP / widget.maxXP)
              .animate(_controller)
            ..addListener(() {
              setState(() {
                _progress = _animation.value;
              });
            });
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('LV. ${widget.level}',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.normal,
                  )),
              Text('${widget.currentXP}/${widget.maxXP} XP',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.normal,
                  )),
            ],
          ),
        ),
        Container(
          height: 20,
          width: double.infinity,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Stack(
            children: [
              FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _progress,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(1.0),
                        AppColors.primaryColor.withOpacity(0.4)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AppColors {
  static Color primaryColor = Color(0xFF39FF14);
}
