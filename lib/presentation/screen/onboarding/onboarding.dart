import 'package:flutter/material.dart';
import 'package:memorable/domain/model/user.dart';
import 'package:memorable/presentation/color/colors.dart';
import 'package:memorable/presentation/provider/onboarding_provider.dart';
import 'package:memorable/presentation/screen/home.dart';
import 'package:memorable/presentation/screen/onboarding/onboarding_step.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OnboardingViewState();
  }
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => OnboardingProvider(),
        child: content(context)
    );
  }

  void goNextView(int index) {
    final Widget nextWidget;
    switch (index) {
      case 1: {
        nextWidget = OnboardingStepTwo(onClickNext: (isMarried) {
          if (!isMarried) {
            goNextView(4);
            return;
          }
          goNextView(2);
        });
      }
      break;
      case 2: {
        nextWidget = OnboardingStepThree(onClickNext: (number) {
          goNextView(3);
        });
      }
      break;
      case 3: {
        nextWidget = OnboardingStepFour(onClickNext: () {
          goNextView(4);
        });
      }
      break;
      default: {
        nextWidget = const HomeView();
      }
      break;
    }

    final PageRouteBuilder builder = PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextWidget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        }
    );

    switch (index) {
      case 1: {
        Navigator.of(context).push(builder);
      }
      break;
      case 2: {
        Navigator.of(context).push(builder);
      }
      break;
      case 3: {
        Navigator.of(context).push(builder);
      }
      break;
      default: {
        Navigator.of(context).pushAndRemoveUntil(builder, (route) => false);
      }
      break;
    }
  }

  Widget content(BuildContext context) {
    return OnboardingStepOne(
      onClickNext: (gender) {
        goNextView(1);
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //     return OnboardingStepTwo(onClickNext: (isMarried) {
        //
        //       if (!isMarried) {
        //         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
        //           return const HomeView();
        //         }), (route) => false);
        //         // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        //         //   return const HomeView();
        //         // }));
        //         return;
        //       }
        //
        //       Navigator.push(context, MaterialPageRoute(builder: (context) {
        //         return OnboardingStepThree(onClickNext: (number) {
        //
        //           Navigator.push(context, MaterialPageRoute(builder: (context) {
        //             return OnboardingStepFour(onClickNext: () {
        //
        //               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
        //                 return const HomeView();
        //               }), (route) => false);
        //             });
        //           }));
        //         });
        //       }));
        //     });
        // }));
      },
    );
  }
}


class OnboardingStepOne extends OnboardingStep {
  OnboardingStepOne({
    Key? key,
    required this.onClickNext,
  }) : super(
      key: key,
      title: "What is your gender?",
      description: "",
      isLast: false,
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                onClickNext(Gender.female);
              },
              child: const Text("Female")
          ),
          TextButton(
              onPressed: () {
                onClickNext(Gender.male);
              },
              child: const Text("Male")
          ),
          TextButton(
              onPressed: () {
                onClickNext(Gender.nonbinary);
              },
              child: const Text("Non-binery")
          ),
        ],
      )
  );

  final void Function(Gender gender) onClickNext;
}

class OnboardingStepTwo extends OnboardingStep {
  OnboardingStepTwo({
    Key? key,
    required this.onClickNext,
  }) : super(
      key: key,
      title: "Are you married",
      description: "",
      isLast: false,
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                onClickNext(true);
              },
              child: const Text("Yes")
          ),
          TextButton(
              onPressed: () {
                onClickNext(false);
              },
              child: const Text("No")
          )
        ],
      ),
  );

  final void Function(bool isMarried) onClickNext;
}

class OnboardingStepThree extends StatefulWidget {
  const OnboardingStepThree({
    Key? key,
    required this.onClickNext
  }): super(key: key);

  final void Function(int number) onClickNext;

  @override
  State<StatefulWidget> createState() => _OnboardingStepThreeState();
}

class _OnboardingStepThreeState extends State<OnboardingStepThree> {
  int _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return OnboardingStepThreeInternal(
      currentValue: _currentValue,
      onClickNext: () {
        widget.onClickNext(_currentValue);
      },
      onChangedNumber: (int number) {
        setState(() {
          _currentValue = number;
        });
      },
    );
  }

}

class OnboardingStepThreeInternal extends OnboardingStep {
  final int currentValue;

  OnboardingStepThreeInternal({
    Key? key,
    required this.currentValue,
    required this.onClickNext,
    required this.onChangedNumber,
  }) : super(
      key: key,
      title: "You got a child?",
      description: "",
      isLast: false,
      child: Column(
        children: [
          NumberPicker(
            itemCount: 5,
            value: currentValue,
            minValue: 0,
            maxValue: 5,
            onChanged: (value) {
              onChangedNumber(value);
            }
          ),
          TextButton(
              onPressed: () {
                onClickNext();
              },
              child: const Text("Select")
          ),

        ],
      ),
  );

  final VoidCallback onClickNext;
  final void Function(int number) onChangedNumber;
}

class OnboardingStepFour extends OnboardingStep {
  OnboardingStepFour({
    Key? key,
    required this.onClickNext,
  }) : super(
    key: key,
    title: "🎉\nGreat!",
    alignment: Alignment.center,
    description: "Let's set up dates you want to keep track of.",
    isLast: true,
    child: Column(
      children: [
        TextButton(
            onPressed: () {
              onClickNext();
            },
            child: const Text("Let's go in 3s")
        )
      ],
    ),
  );

  final VoidCallback onClickNext;
}



/// Not used anylonger
class OnboardingIndicator extends StatefulWidget {
  const OnboardingIndicator({
    Key? key,
    required this.totalSteps,
    required this.currentIndex
  }) : super(key: key);

  final int totalSteps;
  final int currentIndex;

  @override
  State<StatefulWidget> createState() {
    return _OnbordingIndicatorState();
  }
}

class _OnbordingIndicatorState extends State<OnboardingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 35),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < widget.totalSteps; i++)
                if (i == widget.currentIndex) ...[circleBar(true)] else
                  circleBar(false),
            ],
          ),
        ),
      ],
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? AppColors.orange : AppColors.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}