import 'package:flutter/material.dart';
import 'package:petmily/const/petmily_const.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class FeedingPage extends StatefulWidget {
  const FeedingPage({super.key});

  @override
  State<FeedingPage> createState() => _FeedingPageState();
}

class _FeedingPageState extends State<FeedingPage> {
  double _panelHeightOpen = 0;
  double _panelHeight = 95.0;
  final double _panelHeightClosed = 95.0;

  double sliderValue = 0.0;
  Color feedColor = Colors.grey[100]!;

  final PanelController panelController = PanelController();

  BorderRadiusGeometry radius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  Widget _buildHeader() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ForceDraggableWidget(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsed() {
    return Container(
      decoration: BoxDecoration(borderRadius: radius),
      child: Padding(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08, right: MediaQuery.of(context).size.width * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("나나", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
                    SizedBox(height: 3.0),
                    Text("남 / 2kg", style: TextStyle(fontSize: 15.0)),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.error,
                            backgroundColor: Theme.of(context).colorScheme.onError,
                            surfaceTintColor: Theme.of(context).colorScheme.error,
                            padding: const EdgeInsets.all(2.0),
                            shape: const CircleBorder()),
                        onPressed: () {
                          panelController.open();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text("급식"),
                        )),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(2.0), shape: const CircleBorder()),
                      onPressed: () {
                        panelController.open();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text("일정"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel() {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 27.0, 15.0, 15.0),
        child: Column(
          children: [
            SizedBox(height: _panelHeight + 12.0),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: width * 0.45,
                      height: height * 0.15,
                      decoration: BoxDecoration(
                        color: PetmilyConst.dangerColor,
                        borderRadius: PetmilyConst.petmilyBorderRadius,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("현재 섭취량", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
                            Text("0g", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17.0)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    FillContainer(
                      title: "밥그릇",
                      text: "50g",
                      width: width * 0.45,
                      height: height * 0.15,
                      progress: 50,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ],
                ),
                SizedBox(width: height * 0.01),
                FillContainer(
                  title: "남은 사료량",
                  text: "3kg / 6kg",
                  width: width * 0.45,
                  height: height * 0.31,
                  progress: 50,
                ),
              ],
            ),
            SizedBox(
                width: width * 0.85,
                child: Divider(
                  height: height * 0.03,
                  thickness: 2,
                )),
            IgnoreDraggableWidget(
              child: Row(
                children: [
                  Expanded(
                    child: Stack(children: [
                      ClipRRect(
                          borderRadius: PetmilyConst.petmilyBorderRadius,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: height * 0.09,
                              thumbShape: SliderComponentShape.noThumb,
                              trackShape: const RectangularSliderTrackShape(),
                              overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                              inactiveTrackColor: Colors.grey[100]!,
                              activeTrackColor: PetmilyConst.petmilyColor.withOpacity(0.7),
                              tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 0.0),
                            ),
                            child: Slider(
                              value: sliderValue,
                              onChanged: (value) {
                                setState(() {
                                  sliderValue = value;

                                  if (sliderValue == 0) {
                                    feedColor = Colors.grey[100]!;
                                  } else if (sliderValue == 20.0) {
                                    feedColor = PetmilyConst.dangerColor;
                                  } else if (sliderValue == 40.0) {
                                    feedColor = PetmilyConst.warningColor;
                                  } else if (sliderValue == 60.0) {
                                    feedColor = PetmilyConst.safeColor;
                                  } else if (sliderValue == 80.0) {
                                    feedColor = PetmilyConst.warningColor;
                                  } else {
                                    feedColor = PetmilyConst.dangerColor;
                                  }
                                });
                              },
                              max: 100.0,
                              divisions: 5,
                            ),
                          )),
                      Container(
                        height: height * 0.09,
                        padding: EdgeInsets.only(right: height * 0.02),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("${sliderValue.toInt()}g",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      )
                    ]),
                  ),
                  SizedBox(width: height * 0.01),
                  Container(
                    width: width * 0.25,
                    height: height * 0.09,
                    decoration: BoxDecoration(
                      borderRadius: PetmilyConst.petmilyBorderRadius,
                      color: feedColor,
                    ),
                    child: const Center(
                      child: Text(
                        "급식",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * 0.5;

    return SlidingUpPanel(
      backdropEnabled: true,
      backdropOpacity: 0.3,
      minHeight: _panelHeightClosed,
      maxHeight: _panelHeightOpen,
      parallaxEnabled: true,
      controller: panelController,
      panelBuilder: () {
        return _buildPanel();
      },
      header: _buildHeader(),
      collapsed: _buildCollapsed(),
      body: Image.asset('assets/images/cat.jpg', fit: BoxFit.cover),
      borderRadius: radius,
      onPanelSlide: (double pos) => setState(() {
        _panelHeight = _panelHeightClosed - (pos * _panelHeightClosed);
      }),
    );
  }
}

class FillContainer extends StatelessWidget {
  final String title;
  final String text;
  final double width;
  final double height;
  final double progress;
  final Color color;

  const FillContainer(
      {super.key,
      required this.title,
      required this.text,
      required this.width,
      required this.height,
      required this.progress,
      this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: PetmilyConst.petmilyBorderRadius,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            WaveWidget(
              backgroundColor: Colors.grey[100],
              config: CustomConfig(
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.8),
                  color.withOpacity(0.4),
                ],
                durations: [32000, 28000, 25000],
                heightPercentages: [1 - progress / 100, 0.98 - progress / 100, 0.95 - progress / 100],
              ),
              size: Size(width, height),
              waveAmplitude: 1.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
                  Text(text, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 17.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
