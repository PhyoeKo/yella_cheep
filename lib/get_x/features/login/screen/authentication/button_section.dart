import 'package:explore_places/get_x/constant/resources/app_colors.dart';
import 'package:flutter/material.dart';

class AuthButtonSection extends StatelessWidget {
  final AnimationController animationController;
  final Function onPressed;
  final String btnText;

  const AuthButtonSection({
    Key? key,
    required this.animationController,
    required this.onPressed,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _enterAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.2,
        0.4,
        curve: Curves.elasticInOut,
      ),
    ));

    final _iconMovedAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(5, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.5,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _widthAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.elasticInOut,
      ),
    ));

    final _singUpAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.5,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _topMoveAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _topMoveAnimation,
      child: ScaleTransition(
        scale: _enterAnimation,
        child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return GestureDetector(
                onTap: () {
                  onPressed();
                },
                child: Container(
                  height: 52,
                  width: 52 + (250 * _widthAnimation.value),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        8 + 32 * (1 - _widthAnimation.value)),
                    color: Colors.white,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SlideTransition(
                          position: _iconMovedAnimation,
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.brownRedColor,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FadeTransition(
                          opacity: _singUpAnimation,
                          child:  Text(
                            btnText,
                            style: const TextStyle(
                                color: AppColors.brownRedColor,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
