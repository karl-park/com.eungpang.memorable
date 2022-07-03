import 'package:flutter/material.dart';
import 'package:memorable/presentation/color/colors.dart';
import 'package:memorable/presentation/screen/home.dart';

abstract class OnboardingStep extends StatelessWidget {
  const OnboardingStep({
    Key? key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.alignment,
    required this.child,
    required this.isLast,

  }) : super(key: key);

  final Alignment? alignment;

  final String title;
  final String description;
  final String? imageUrl;
  final Widget? child;
  final bool isLast;

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
          alignment: Alignment.center,
          margin: const EdgeInsets.all(24),
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                letterSpacing: 2.0
            ),
          ),
        )
    );
    content.add(
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(24),
            child: Text(
              description,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: AppColors.black,
                  letterSpacing: 2.0
              ),
            )
        )
    );

    return content;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>? actions;
    if (!isLast) {
      actions = [];
      actions.add(TextButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return const HomeView();
            }));
          },
          child: const Text("Skip")
      ));
    }

    Widget? leadingIcon;
    if (Navigator.of(context).canPop() && !isLast) {
      leadingIcon = IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.of(context).pop()
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          actions: actions,
          leading: leadingIcon,
        ),
        body: Container(
          alignment: alignment ?? Alignment.topLeft,
          color: AppColors.white,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              ... content(context),
              const Spacer(),
              if (child != null) child!
            ]
          )
        )
    );
  }
}