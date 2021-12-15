import 'package:ecommerce_flutter/screens/login.dart';
import 'package:ecommerce_flutter/shared/components/components.dart';
import 'package:ecommerce_flutter/shared/services/shared_prefrences/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardCard {
  final String img;
  final String title;
  final String info;

  OnBoardCard({required this.img, required this.title, required this.info});
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreen createState() => _OnboardingScreen();
}

class _OnboardingScreen extends State<OnboardingScreen> {
  List<OnBoardCard> onBoardCards = [
    OnBoardCard(
        img: 'images/onboard1.png',
        title: 'On Boarding 1 Title',
        info: 'On Boarding 1 Title'),
    OnBoardCard(
        img: 'images/onboard2.png',
        title: 'On Boarding 2 Title',
        info: 'On Boarding 2 Title'),
    OnBoardCard(
        img: 'images/onboard3.png',
        title: 'On Boarding 3 Title',
        info: 'On Boarding 3 Title'),
  ];

  var pgController = PageController(initialPage: 0);
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              CacheHandler.saveData(key: 'onboardingDone', value: true);
              navigateAndRemoveUntil(context, LoginScreen());
            },
            child: Text('SKIP'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsetsDirectional.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (i) {
                  if (i == onBoardCards.length - 1)
                    setState(() {
                      isLast = true;
                    });
                  else
                    setState(() {
                      isLast = false;
                    });
                },
                physics: BouncingScrollPhysics(),
                controller: pgController,
                itemBuilder: (context, i) => onBoardingPage(onBoardCards[i]),
                itemCount: onBoardCards.length,
              ),
            ),
            SizedBox(height: 40.0),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pgController,
                  count: onBoardCards.length,
                  effect: WormEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Color.fromRGBO(212, 14, 20, 1)),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == false) {
                      pgController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.easeInBack,
                      );
                    } else {
                      CacheHandler.saveData(key: 'onboardingDone', value: true);
                      navigateAndRemoveUntil(context, LoginScreen());
                    }
                  },
                  child: Icon(Icons.forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget onBoardingPage(card) => Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Image(
              width: 1500.0,
              height: 1500.0,
              image: AssetImage('${card.img}'),
            ),
          ),
          Text(
            '${card.title}',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40.0),
          Text('${card.info}'),
          SizedBox(height: 40.0),
        ],
      );
}
