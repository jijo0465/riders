import 'package:flutter/material.dart';
import 'package:riders/components/custom_painter.dart';

class CountDownTimer extends StatefulWidget {
  static AnimationController controller;
  final double fontSize;
  static VoidCallback onTimeOut;
  const CountDownTimer({Key key, this.fontSize}) : super(key: key);
  @override
  _CountDownTimerState createState() => _CountDownTimerState();


  void activate(){
    controller.addStatusListener(listen);
        if (controller.isAnimating)
          controller.stop();
        else {
          controller.reverse(
              from: controller.value == 0.0 ? 1.0 : controller.value);
        }
      }
    
      void listen(AnimationStatus status) {
        if(status==AnimationStatus.dismissed){
          CountDownTimer.onTimeOut();
        }
  }
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {

  String get timerString {
    Duration duration = CountDownTimer.controller.duration * CountDownTimer.controller.value;
    // if(duration.inMinutes==0&&duration.inSeconds==0){
    //   widget.onTimeOut();
    // }
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }
  @override
  void dispose() {
    CountDownTimer.controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    CountDownTimer.controller = AnimationController(
      vsync: this,
      duration: Duration(minutes:20, milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedBuilder(
          animation: CountDownTimer.controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                    animation: CountDownTimer.controller,
                                  )),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Text(
                                    timerString,
                                    style: TextStyle(
                                      fontSize: widget.fontSize,
                                      color:  Colors.deepPurple),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.only(bottom: 50),
                      //   child: AnimatedBuilder(
                      //       animation: CountDownTimer.controller,
                      //       builder: (context, child) {
                      //         return FloatingActionButton.extended(
                      //             onPressed: () {
                      //               if (CountDownTimer.controller.isAnimating)
                      //                 CountDownTimer.controller.stop();
                      //               else {
                      //                 CountDownTimer.controller.reverse(
                      //                     from: CountDownTimer.controller.value == 0.0
                      //                         ? 1.0
                      //                         : CountDownTimer.controller.value);
                      //               }
                      //             },
                      //             icon: Icon(CountDownTimer.controller.isAnimating
                      //                 ? Icons.pause
                      //                 : Icons.play_arrow),
                      //             label: Text(CountDownTimer.controller.isAnimating
                      //                 ? "Pause"
                      //                 : "Play"));
                      //       }),
                      // ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  // static void startTimer() {
  //   if (CountDownTimer.controller.isAnimating)
  //     CountDownTimer.controller.stop();
  //   else {
  //     CountDownTimer.controller.reverse(
  //         from: CountDownTimer.controller.value == 0.0 ? 1.0 : CountDownTimer.controller.value);
  //   }
  // }
}
