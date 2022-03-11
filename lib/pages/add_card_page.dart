import 'package:bank_app/pages/conponents/card_field.dart';
import 'package:bank_app/pages/create_card_page.dart';
import 'package:bank_app/services/hive_service.dart';
import 'package:bank_app/services/retro_fit_service.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:bank_app/models/card_model.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  static const id = "/add_card_page";

  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  List<CCard> cards = [];

  Stream<List<CCard>> getData() {
    return Stream.periodic(const Duration(seconds: 1))
        .asyncMap((event) => getNetworkData());
  }

  Future<List<CCard>> getNetworkData() async {
    final dio = Dio();
    final network = RetroFitNetwork(dio);

    List<CCard> cards = await network.getCards();
    List<CCard> dataCards = await HiveDB.loadData();

    if (dataCards.length >= cards.length) {
      for (var e in cards) {
        await network.deleteCard(e.id!);
      }
      for (var e in dataCards) {
        await network.createCard(e);
      }
    }

    return cards;
  }

  List<Color> colors = [
    Colors.blue,
    Colors.black,
    Colors.yellow,
    Colors.green,
    Colors.red,
    Colors.deepPurple,
    Colors.pink,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Column(
              children: [
                header(),
                const SizedBox(height: 40),
                StreamBuilder(
                  stream: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<CCard> cards = snapshot.data as List<CCard>;
                        List<Widget> list = [];
                        int index = 0;
                        for (var card in cards) {
                          index++;
                          list.addAll([
                            cardFields(
                              card: card,
                              index: index % (colors.length - 1),
                            ),
                            const SizedBox(height: 20),
                          ]);
                        }
                        return Column(children: list);
                      } else if (snapshot.hasError) {
                        List<CCard> cards = HiveDB.loadData();
                        List<Widget> list = [];
                        int index = 0;
                        for (var card in cards) {
                          index++;
                          list.addAll([
                            cardFields(
                              card: card,
                              index: index % (colors.length - 1),
                            ),
                            const SizedBox(height: 20),
                          ]);
                        }
                        return Column(children: list);
                      } else {
                        return const SizedBox.shrink();
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      bool isWait = true;

                      Future.delayed(const Duration(seconds: 20)).then((value) {
                        isWait = false;
                      });

                      List<CCard> cards = HiveDB.loadData();
                      List<Widget> list = [];
                      int index = 0;
                      for (var card in cards) {
                        index++;
                        list.addAll([
                          cardFields(
                            card: card,
                            index: index % (colors.length - 1),
                          ),
                          const SizedBox(height: 20),
                        ]);
                      }

                      return isWait ? Column(
                        children: const [
                          SizedBox(height: 20),
                          Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                          SizedBox(height: 20),
                        ],
                      ) : Column(children: list);
                    } else {
                      return Column(
                        children: [
                          const SizedBox(height: 300),
                          Center(
                            child: Text('State: ${snapshot.connectionState}'),
                          ),
                        ],
                      );
                    }
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, CreateCardPage.id);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 230,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.2),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add_box_outlined,
                          size: 60,
                          color: Colors.grey,
                        ),
                        Text(
                          "Add new Card",
                          style: TextStyle(fontSize: 22, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardFields({required CCard card, required int index}) {
    return CardField(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: colors[index].withOpacity(0.5),
        ),
        child: Column(
          children: [
            // ! visa
            visaImage(),
            const SizedBox(height: 30),
            // ! card number
            cardNumber(card),
            const SizedBox(height: 30),
            // ! card name
            cardBottom(card),
          ],
        ),
      ),
    );
  }

  Padding cardBottom(CCard card) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "CARD HOLDER",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${card.name}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "EXPIRES",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${card.month}/${card.year}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Text cardNumber(CCard card) => Text(
        "${card.cardNumber}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget visaImage() {
    return Row(
      children: [
        const Spacer(),
        SizedBox(
          height: 60,
          width: 80,
          child: Image.asset("assets/icons/visa.png"),
        ),
      ],
    );
  }

  Row header() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Good Morning,",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            Text(
              "Eugene",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            )
          ],
        ),
        const Spacer(),
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Image.asset(
            "assets/images/im_user.png",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
