
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class TopPage extends StatefulWidget {
  const TopPage({super.key});

  @override
  State<TopPage> createState() => _TopPageState();
}
  

class _TopPageState extends State<TopPage> {
  late String 
      // ignore: unused_field
      _item,
      // ignore: unused_field
      _payment,
      // ignore: unused_field
      _delivery;

  
  final itemController = TextEditingController();
  final paymentController = TextEditingController();
  final deliveryController = TextEditingController();
  final _Key = GlobalKey<FormState>();

  bool validate() {
    if (_Key.currentState!.validate()) {
      _Key.currentState!.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 50.0),
          child: Center(
            child: Column(children: [
              Text(
                "Top Up",
                style: TextStyle(color: Colors.black),
              ),
              
            ]),
          ),
        ),
      ),
      body:
        Column(
          children: [
            Padding(
                      padding: const EdgeInsets.only(top: 100, left: 50,),
                      child: TextFormField(
                        controller: paymentController,
                        decoration: const InputDecoration(
                          labelText: 'Mode Of Payment',
                          hintText: 'VISA/MOMO/CREDITCARD/PAYPAL',
                          suffixIcon: Icon(
                            FontAwesomeIcons.paypal,
                            size: 17,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty && value.length < 4) {
                            return 'Provide a valid mode';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _payment = value!;
                        },
                      ),
                    ),
               Padding(
                  padding: const EdgeInsets.only(top: 1.0 ,left: 100,),
                  child: TextFormField(
                    controller: itemController,
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                      hintText: 'Enter the preferred amount',
                      suffixIcon: Icon(
                        FontAwesomeIcons.envelope,
                        size: 17,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty && value.length <= 2) {
                        return 'Provide a valid number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _item = value!;
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10.0,  right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                      
                    }, 
                      child: const Text('Top Up'),
                    ),
                  ),     
          ],
        ),
                
                
               
              
    );
  }
}