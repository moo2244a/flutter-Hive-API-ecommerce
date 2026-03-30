import 'package:ecommers_app/core/utils/ui_constant.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hint: Text(UiConstant.search),

              prefixIcon: Icon(Icons.search),
              suffixIcon: Card(
                color: Theme.of(context).colorScheme.primary,

                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.filter_alt_outlined, size: 30),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
