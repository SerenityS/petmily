import 'package:flutter/material.dart';
import 'package:petmily/const/petmily_const.dart';
import 'package:petmily/data/model/pet.dart';

class ConsumeCalc {
  ConsumeCalc({required this.pet}) {
    sufficientConsume = calcSufficient();
  }

  final Pet pet;
  int sufficientConsume = 0;

  int calcSufficient() {
    // RER(kcal/day) = (체중(kg) * 30) + 70
    double consume = (pet.weight * 30) + 70;

    // DER = RER * 고유계수
    // pet.petType: 1: 4개월 미만, 2: 5개월 ~ 성견, 3: 비중성화, 4: 중성화, 5: 과체중, 6: 비만
    switch (pet.petType) {
      case 1:
        consume *= 3.0;
        break;
      case 2:
        consume *= 2.0;
        break;
      case 3:
        consume *= 1.8;
        break;
      case 4:
        consume *= 1.6;
        break;
      case 5:
        consume *= 1.4;
        break;
      case 6:
        consume *= 1.0;
        break;
    }

    // 일일 사료 급여량(g)
    consume /= pet.feedKcal;

    return consume.toInt();
  }

  Color getFeedingColor(double value) {
    Color feedColor = Colors.grey[100]!;

    // 4번
    if (pet.petType == 1) {
      if (value == 0) {
        feedColor = Colors.grey[100]!;
      } else if (value / sufficientConsume <= 0.1) {
        feedColor = PetmilyConst.dangerColor;
      } else if (value / sufficientConsume <= 0.2) {
        feedColor = PetmilyConst.warningColor;
      } else if (value / sufficientConsume <= 0.35) {
        feedColor = PetmilyConst.safeColor;
      } else if (value / sufficientConsume <= 0.5) {
        feedColor = PetmilyConst.warningColor;
      } else {
        feedColor = PetmilyConst.dangerColor;
      }
      // 3번
    } else {
      if (value == 0) {
        feedColor = Colors.grey[100]!;
      } else if (value / sufficientConsume <= 0.125) {
        feedColor = PetmilyConst.dangerColor;
      } else if (value / sufficientConsume <= 0.25) {
        feedColor = PetmilyConst.warningColor;
      } else if (value / sufficientConsume <= 0.475) {
        feedColor = PetmilyConst.safeColor;
      } else if (value / sufficientConsume <= 0.6) {
        feedColor = PetmilyConst.warningColor;
      } else {
        feedColor = PetmilyConst.dangerColor;
      }
    }
    return feedColor;
  }

  Color getStatusColor(int nowConsume) {
    Color nowColor = PetmilyConst.safeColor;

    if (nowConsume / sufficientConsume <= 0.5) {
      nowColor = PetmilyConst.dangerColor;
    } else if (nowConsume / sufficientConsume <= 0.8) {
      nowColor = PetmilyConst.warningColor;
    } else if (nowConsume / sufficientConsume <= 1.2) {
      nowColor = PetmilyConst.safeColor;
    } else if (nowConsume / sufficientConsume <= 1.4) {
      return PetmilyConst.warningColor;
    } else {
      return PetmilyConst.dangerColor;
    }

    return nowColor;
  }
}
