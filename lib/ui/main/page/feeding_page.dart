import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petmily/const/petmily_const.dart';
import 'package:petmily/controller/history_controller.dart';
import 'package:petmily/controller/petmily_controller.dart';
import 'package:petmily/data/model/pet.dart';
import 'package:petmily/ui/main/controller/feeding_controller.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class FeedingPage extends GetView<FeedingPageController> {
  FeedingPage({super.key});

  final PanelController panelController = PanelController();
  final PetmilyController _petmilyController = Get.find<PetmilyController>();

  final BorderRadiusGeometry radius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  @override
  Widget build(BuildContext context) {
    controller.panelHeightOpen.value = MediaQuery.of(context).size.height * 0.5;
    controller.panelHeight.value = controller.panelHeightClosed;

    return SlidingUpPanel(
      controller: panelController,
      minHeight: controller.panelHeightClosed,
      maxHeight: controller.panelHeightOpen.value,
      backdropEnabled: true,
      backdropOpacity: 0.3,
      borderRadius: radius,
      parallaxEnabled: true,
      body: Image.asset('assets/images/cat.jpg', fit: BoxFit.cover),
      header: _buildHeader(context),
      collapsed: _buildCollapsed(context),
      panelBuilder: () {
        return _buildPanel(context);
      },
      onPanelSlide: (double pos) {
        controller.panelHeight.value = controller.panelHeightClosed - (pos * controller.panelHeightClosed);
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
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

  Widget _buildCollapsed(BuildContext context) {
    Pet pet = _petmilyController.petList[0];

    return Container(
      decoration: BoxDecoration(borderRadius: radius),
      child: Padding(
        padding:
            EdgeInsets.only(top: 12.0, left: MediaQuery.of(context).size.width * 0.08, right: MediaQuery.of(context).size.width * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(pet.name, style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500)),
            const SizedBox(height: 3.0),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.grey, fontSize: 15.0),
                children: [
                  TextSpan(text: pet.isMale ? "남" : "여"),
                  const TextSpan(text: " / "),
                  TextSpan(text: "${pet.age}살"),
                  const TextSpan(text: " / "),
                  TextSpan(text: "${pet.weight.toStringAsFixed(1)}kg"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    int todayConsume = Get.find<HistoryController>().todayConsume.value;
    int todayConsumeKcal = (todayConsume * _petmilyController.petList[0].feedKcal).toInt();

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 27.0, 15.0, 15.0),
        child: Obx(
          () => Column(
            children: [
              SizedBox(height: controller.panelHeight.value + 12.0),
              Row(
                children: [
                  Column(
                    children: [
                      RoundedContainer(
                        width: width * 0.45,
                        height: height * 0.15,
                        color: PetmilyConst.dangerColor,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("금일 섭취량", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0)),
                              Text("${todayConsume}g / ${todayConsumeKcal}kcal",
                                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 17.0)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      FillContainer(
                        title: "밥그릇",
                        text: "50g / 0kcal",
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
                        Material(
                          borderRadius: PetmilyConst.petmilyBorderRadius,
                          elevation: 2.0,
                          child: ClipRRect(
                              borderRadius: PetmilyConst.petmilyBorderRadius,
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: PetmilyConst.petmilyColor.withOpacity(0.7),
                                  inactiveTrackColor: Colors.grey[100]!,
                                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                                  tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 0.0),
                                  thumbShape: SliderComponentShape.noThumb,
                                  trackHeight: height * 0.09,
                                  trackShape: const RectangularSliderTrackShape(),
                                ),
                                child: Slider(
                                  value: controller.sliderValue.value,
                                  max: 100.0,
                                  divisions: 5,
                                  onChanged: (value) {
                                    controller.sliderValue.value = value;

                                    if (controller.sliderValue.value == 0) {
                                      controller.feedColor.value = Colors.grey[100]!;
                                    } else if (controller.sliderValue.value == 40.0 || controller.sliderValue.value == 80.0) {
                                      controller.feedColor.value = PetmilyConst.warningColor;
                                    } else if (controller.sliderValue.value == 60.0) {
                                      controller.feedColor.value = PetmilyConst.safeColor;
                                    } else {
                                      controller.feedColor.value = PetmilyConst.dangerColor;
                                    }
                                  },
                                ),
                              )),
                        ),
                        Container(
                          height: height * 0.09,
                          padding: EdgeInsets.only(right: height * 0.02),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("${controller.sliderValue.toInt()}g",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(width: height * 0.01),
                    RoundedContainer(
                      width: width * 0.25,
                      height: height * 0.09,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: PetmilyConst.petmilyBorderRadius),
                          foregroundColor: Colors.white,
                          backgroundColor: controller.feedColor.value,
                        ),
                        onPressed: () async {
                          await _petmilyController.feeding(controller.sliderValue.value.toInt(), _petmilyController.petList[0].chipId);
                        },
                        child: const Center(
                          child: Text(
                            "급식",
                            style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
    return Material(
      borderRadius: PetmilyConst.petmilyBorderRadius,
      elevation: 2.0,
      child: ClipRRect(
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
      ),
    );
  }
}

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({super.key, required this.child, required this.width, required this.height, this.color});

  final Widget child;
  final double width;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: PetmilyConst.petmilyBorderRadius,
      elevation: 2.0,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: PetmilyConst.petmilyBorderRadius,
          color: color ?? Colors.grey[100]!,
        ),
        child: child,
      ),
    );
  }
}
