import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthy_lux/Preferences/app_theme.dart';
import 'package:healthy_lux/components/appbar.dart';
import 'package:healthy_lux/components/bmi_button.dart';
import 'package:healthy_lux/components/reusable_container.dart';
import 'package:healthy_lux/screen/bmi/bmi_result.dart';

import '../../healthy_lux_enum.dart';
import 'bmi_call_result.dart';

class BMI extends StatefulWidget {
  const BMI({Key? key}) : super(key: key);

  @override
  _BMIState createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  Gender? selectedGender;

  Color femaleCont = AppTheme.greyColor;
  Color maleCont = AppTheme.redAccentColor;

  int height = 170;
  int weight = 52;
  int age = 20;

  void navigationToResult(double result) {
    CalculateResult obj = CalculateResult(weight, height);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BMIResult(
                result2: obj.calculateResult(),
                msg: obj.msg,
                des: obj.getDescription())));
  }

  @override
  void initState() {
    setState(() {
      selectedGender = Gender.male;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.whiteColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: BuildAppBar(
          title: 'BMI Calculator',
          backButton: true,
        ),
      ),
      body: bmiBody(),
    );
  }

  Widget bmiBody() {
    return SafeArea(
        child: Column(
      children: [
        Expanded(child: genderButton()),
        Expanded(child: sliderHeight()),
        Expanded(child: weightAgeButton()),
        GestureDetector(
          onTap: () {
            navigationToResult(12.0);
          },
          child: Container(
            height: 75.0,
            width: double.infinity,
            color: Colors.redAccent,
            margin: const EdgeInsets.only(top: 18.0),
            child: Center(
              child: Text(
                'CALCULATE BMI',
                style: AppTheme.defaultTextStyle25Black(false),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget genderButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: ReusableContainer(
            opt: () {
              setState(() {
                selectedGender = Gender.male;
              });
            },
            customChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                const Icon(
                  FontAwesomeIcons.mars,
                  size: 110,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('MALE', style: AppTheme.defaultTextStyle18White(false)),
              ],
            ),
            contColor: selectedGender == Gender.male
                ? AppTheme.redAccentColor
                : AppTheme.greyColor,
          ),
        ),
        Expanded(
          child: ReusableContainer(
            opt: () {
              setState(() {
                selectedGender = Gender.female;
              });
            },
            customChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 5,
                ),
                const Icon(
                  FontAwesomeIcons.venus,
                  size: 110,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('FEMALE', style: AppTheme.defaultTextStyle18White(false)),
              ],
            ),
            contColor: selectedGender == Gender.female
                ? AppTheme.redAccentColor
                : AppTheme.greyColor,
          ),
        ),
      ],
    );
  }

  Widget sliderHeight() {
    return ReusableContainer(
        contColor: AppTheme.redAccentColor,
        customChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'SELECT HEIGHT',
              style: AppTheme.defaultTextStyle18White(false),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  height.toString(),
                  style: AppTheme.defaultTextStyle45White(true),
                ),
                Text(
                  'CM',
                  style: AppTheme.defaultTextStyle18White(false),
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 16.0),
                thumbColor: AppTheme.greyColor,
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 50.0),
                activeTrackColor: AppTheme.whiteColor,
                inactiveTrackColor: AppTheme.greenColor,
              ),
              child: Slider(
                value: height.toDouble(),
                min: 50.0,
                max: 280.0,
                onChanged: (double changeHeight) {
                  setState(() {
                    height = changeHeight.round();
                  });
                },
              ),
            ),
          ],
        ));
  }

  Widget weightAgeButton() {
    return Row(
      children: <Widget>[
        Expanded(
          child: ReusableContainer(
            contColor: AppTheme.redAccentColor,
            customChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'WEIGHT',
                  style: AppTheme.defaultTextStyle18White(false),
                ),
                Text(
                  weight.toString(),
                  style: AppTheme.defaultTextStyle45White(true),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BtnPlusMinus(
                      buttonIcon: FontAwesomeIcons.minus,
                      onPress: () {
                        setState(() {
                          weight--;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    BtnPlusMinus(
                      buttonIcon: FontAwesomeIcons.plus,
                      onPress: () {
                        setState(() {
                          weight++;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ReusableContainer(
            contColor: AppTheme.redAccentColor,
            customChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'AGE',
                  style: AppTheme.defaultTextStyle18White(false),
                ),
                Text(
                  age.toString(),
                  style: AppTheme.defaultTextStyle45White(true),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BtnPlusMinus(
                      buttonIcon: FontAwesomeIcons.minus,
                      onPress: () {
                        setState(() {
                          age--;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    BtnPlusMinus(
                      buttonIcon: FontAwesomeIcons.plus,
                      onPress: () {
                        setState(() {
                          age++;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
