import 'package:flutter/material.dart';


void showEditPriceDialog({required BuildContext context, required Function(int price) onPriceSaved,}) {
  final TextEditingController _controller = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('تعديل سعر الهاتف'),
        content: TextField(
          controller: _controller,
          keyboardType: TextInputType.number, // Only accept numbers
          decoration: InputDecoration(
            hintText: 'أدخل السعر',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: Text('رجوع'),
          ),
          TextButton(
            onPressed: () {
              final String input = _controller.text;
              if (input.isEmpty) {
                // Show a message if the text field is empty
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('يرجى إدخال سعر صحيح')),
                );
              } else {
                final int? price = int.tryParse(input);
                if (price != null) {

  onPriceSaved(price);
                  Navigator.of(context).pop(); 
                
                } else {
                  // Show a message if the input is not a valid integer
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('يرجى إدخال رقم صحيح')),
                  );
                }
              }
            },
            child: Text("حفظ"),
          ),
        ],
      );
    },
  );
}










