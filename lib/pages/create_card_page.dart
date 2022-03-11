import 'package:bank_app/models/card_model.dart';
import 'package:bank_app/pages/add_card_page.dart';
import 'package:bank_app/services/hive_service.dart';
import 'package:flutter/material.dart';

import 'conponents/card_formatter.dart';

class CreateCardPage extends StatefulWidget {
  const CreateCardPage({Key? key}) : super(key: key);

  static const id = "/create_card_page";

  @override
  _CreateCardPageState createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardMonthController = TextEditingController();
  TextEditingController cardYearController = TextEditingController();
  TextEditingController cardCVV2Controller = TextEditingController();

  void addCard() async {
    CCard card = CCard(
      cardNumber: cardNumberController.text.toString(),
      month: cardMonthController.text.toString(),
      year: cardYearController.text.toString(),
      cvv2: cardCVV2Controller.text.toString(),
    );

    List<CCard> listCards = await HiveDB.loadData();
    listCards.add(card);
    HiveDB.storeData(listCards);

    Navigator.pushReplacementNamed(context, AddCardPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // ! background
            background(context),

            // ! body
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Add your card",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.code,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Fill in the fields below or use camera phone",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Your card number",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  cardNumberTextField(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      textExpiry(),
                      const SizedBox(width: 40),
                      cVV2Build(),
                    ],
                  ),
                  const SizedBox(height: 70),
                  Center(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minWidth: double.infinity,
                      height: 55,
                      color: Colors.blue.shade400,
                      onPressed: () => addCard(),
                      child: const Text(
                        "Add Card",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column cVV2Build() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "CVV2",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: TextField(
                controller: cardCVV2Controller,
                maxLength: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Column textExpiry() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Expiry date",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            SizedBox(
              width: 80,
              child: TextField(
                controller: cardMonthController,
                maxLength: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: TextField(
                controller: cardYearController,
                maxLength: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  TextFormField cardNumberTextField() {
    return TextFormField(
      textAlign: TextAlign.center,
      inputFormatters: [CardInputFormatter()],
      onChanged: (input) {
        setState(() {});
      },
      controller: cardNumberController,
      style: const TextStyle(color: Colors.black, fontSize: 18),
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.blueGrey, // * it well be cool
          fontSize: 18,
        ),
      ),
    );
  }

  SizedBox background(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
