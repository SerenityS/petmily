import 'package:flutter/material.dart';
import 'package:petmily/const/petmily_const.dart';
import 'package:petmily/ui/main/widget/bottom_nav_bar.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double _panelHeightOpen = 0;
  double _panelHeight = 95.0;
  final double _panelHeightClosed = 95.0;

  double sliderValue = 10.0;
  Color thumbColor = Colors.green;

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
                      height: height * 0.14,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: PetmilyConst.petmilyBorder,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("연결 상태", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
                            Text("좋음", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17.0)),
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
                      color: PetmilyConst.petmilyColor,
                    ),
                  ],
                ),
                SizedBox(width: height * 0.01),
                FillContainer(
                  title: "남은 사료량",
                  text: "3kg / 6kg",
                  width: width * 0.45,
                  height: height * 0.3,
                  progress: 50,
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            Row(
              children: [
                Container(
                  width: width * 0.91,
                  height: height * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: PetmilyConst.petmilyBorder,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.2,
                          height: width * 0.2,
                          child: Material(
                            color: Colors.grey[100],
                            child: InkWell(
                              borderRadius: PetmilyConst.petmilyBorder,
                              onTap: () {},
                              child: const Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("급식량", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
                            Text("30g", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
                          ],
                        ),
                        Container(
                          width: width * 0.2,
                          height: width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: PetmilyConst.petmilyBorder,
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Text(
                              "+",
                              style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Container(
            //   width: width,
            //   height: height * 0.15,
            //   decoration: BoxDecoration(color: Colors.grey[100], borderRadius: PetmilyConst.petmilyBorder),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       SfSliderTheme(
            //         data: SfSliderThemeData(
            //           activeTrackColor: PetmilyConst.petmilyColor.withOpacity(0.8),
            //           thumbColor: thumbColor,
            //         ),
            //         child: SfSlider(
            //           min: 10.0,
            //           max: 50.0,
            //           value: sliderValue,
            //           interval: 10,
            //           stepSize: 10.0,
            //           showTicks: true,
            //           showLabels: true,
            //           onChanged: ((var values) {
            //             sliderValue = values;

            //             if (values == 10.0) {
            //               thumbColor = Colors.red[200]!;
            //             } else if (values == 20.0) {
            //               thumbColor = Colors.yellow[200]!;
            //             } else if (values == 30.0) {
            //               thumbColor = Colors.green[200]!;
            //             } else if (values == 40.0) {
            //               thumbColor = Colors.yellow[200]!;
            //             } else {
            //               thumbColor = Colors.red[200]!;
            //             }
            //           }),
            //         ),
            //       ),
            //       SizedBox(height: height * 0.01),
            //       ElevatedButton(onPressed: () {}, child: Text("급식")),
            //       SizedBox(height: height * 0.01),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * 0.6;

    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SlidingUpPanel(
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
        ),
        bottomNavigationBar: const BottomNavBar());
  }
}

class FillContainer extends StatelessWidget {
  String title;
  String text;
  double width;
  double height;
  double progress;
  Color color;

  FillContainer(
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
      borderRadius: PetmilyConst.petmilyBorder,
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
