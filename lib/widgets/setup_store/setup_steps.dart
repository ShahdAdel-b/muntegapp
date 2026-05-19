import 'package:flutter/material.dart';

class SetupSteps extends StatelessWidget {
  final int currentStep;

  const SetupSteps({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      ["بيانات المتجر", Icons.storefront_rounded],
      ["معلومات التواصل", Icons.phone_rounded],
      ["الشحن والدفع", Icons.local_shipping_rounded],
      ["مراجعة", Icons.fact_check_rounded],
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 9),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xffE5E7EB),
          ),
        ),
      ),
      child: Row(
        children: List.generate(
          steps.length,
              (index) {
            final isActive = index == currentStep;
            final isDone = index < currentStep;

            return Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      if (index != 0)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: isDone
                                ? const Color(0xff087A45)
                                .withOpacity(.25)
                                : const Color(0xffE5E7EB),
                          ),
                        ),

                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 31,
                            height: 31,
                            decoration: BoxDecoration(
                              color: isActive || isDone
                                  ? const Color(0xff087A45)
                                  : const Color(0xffEEF0F3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              steps[index][1] as IconData,
                              size: 16,
                              color: isActive || isDone
                                  ? Colors.white
                                  : const Color(0xff7B8494),
                            ),
                          ),

                          if (isDone)
                            Positioned(
                              bottom: -2,
                              left: -2,
                              child: Container(
                                width: 13,
                                height: 13,
                                decoration: const BoxDecoration(
                                  color: Color(0xff087A45),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 9,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),

                      if (index != steps.length - 1)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: index < currentStep
                                ? const Color(0xff087A45)
                                .withOpacity(.25)
                                : const Color(0xffE5E7EB),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Text(
                    steps[index][0] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: isActive
                          ? FontWeight.w900
                          : FontWeight.w600,
                      color: isActive
                          ? const Color(0xff111827)
                          : const Color(0xff8B94A3),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}