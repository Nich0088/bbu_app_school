import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingContainerWidget extends StatelessWidget {
  final Widget child;
  final bool isShowLoading;

  const LoadingContainerWidget({
    super.key,
    required this.child,
    this.isShowLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isShowLoading)
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color(0xA10E162C),
            ),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.width * 0.18,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Lottie.asset(
                  "assets/loading.json",
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
