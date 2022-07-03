import 'package:flutter/material.dart';
import 'package:memorable/presentation/color/colors.dart';
import 'package:memorable/presentation/screen/home.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OnboardingViewState();
  }
}

class _OnboardingViewState extends State<OnboardingView> {
  int _pageIndex = 0;
  PageController pageController = PageController();

  List<Widget> onboardingSteps = <Widget>[
    const OnboardingStep(
      title: "Step1",
      description: "Step1 description",
      imageUrl: "https://img.icons8.com/doodle/344/apple-calendar--v1.png",
    ),
    const OnboardingStep(
      title: "Step2",
      description: "Step2 description",
      imageUrl: "https://img.icons8.com/color/344/friends--v1.png",
    ),
    const OnboardingStep(
      title: "Step3",
      description: "Step3 description",
      imageUrl: "https://image.shutterstock.com/image-vector/notification-icon-vector-material-design-600w-759841507.jpg",
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        pageView(),
        OnboardingIndicator(
          totalSteps: onboardingSteps.length,
          currentIndex: _pageIndex
        ),
        Visibility(
          visible: _pageIndex == onboardingSteps.length - 1,
          child: Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context = context,
                    MaterialPageRoute(builder: (context) {
                      return const HomeView();
                    })
                );
              },
              shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(26))
              ),
              child: const Icon(Icons.arrow_forward),
          ),
        ))
      ],
    );
  }

  Widget pageView() {
    return Container(
      margin: const EdgeInsets.only(top: 180),
      child: PageView.builder(
          controller: pageController,
          physics: const ClampingScrollPhysics(),
          onPageChanged: (int index) {
            getChangedPageAndMoveBar(index);
          },
          itemCount: onboardingSteps.length,
          itemBuilder: (context, index) {
            return onboardingSteps[index];
          }
      )
    );
  }

  void getChangedPageAndMoveBar(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

}

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

class OnboardingStep extends StatelessWidget {
  const OnboardingStep({
    Key? key,
    required this.title,
    required this.description,
    this.imageUrl
  }) : super(key: key);

  final String title;
  final String description;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: content(context),
    );
  }

  List<Widget> content(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;

    List<Widget> content = [];
    if (imageUrl != null) {
      content.add(Image.network(
          imageUrl!,
        width: width * 0.7
      ));
    }

    content.add(
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: AppColors.green,
                letterSpacing: 2.0
            ),
          ),
      )
    );
    content.add(
        Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
                description,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w100,
                    color: AppColors.green,
                    letterSpacing: 2.0
                ),
            )
        )
    );

    return content;
  }
}