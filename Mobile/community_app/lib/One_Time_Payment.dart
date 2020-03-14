import 'package:flutter/material.dart';
import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:flutter/rendering.dart';
import 'package:credit_card/credit_card_widget.dart';

class One_Time_Payment extends StatefulWidget{
  @override
  _One_Time_Payment createState() => new _One_Time_Payment();
}

class _One_Time_Payment extends State<One_Time_Payment>{
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: new AppBar(
          title: new Text('One-time Payment'),
          backgroundColor: Colors.black54,
        ),
        body: SafeArea(
          child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              height: 200,
              width: MediaQuery
                .of(context)
                .size
                .width,
              animationDuration: Duration(milliseconds: 1000)
            ),
            new OutlineButton(
              child: Text(
                'Proceed to Pay',
                style: TextStyle(color: Colors.blue)
              ),
              onPressed: null,
              shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  onCreditCardModelChange: onModelChange,
                ),
              ),
            )
          ],
        ),
    ),
    );
  }
  void onModelChange(CreditCardModel model)
  {
    setState(() {
      cardNumber = model.cardNumber;
      expiryDate = model.expiryDate;
      cardHolderName = model.cardHolderName;
      cvvCode = model.cvvCode;
      isCvvFocused = model.isCvvFocused;
    });
  }
}