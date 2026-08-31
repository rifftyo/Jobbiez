import 'package:flutter/material.dart';
import 'package:jobbiez/common/constants.dart';
import 'package:jobbiez/presentation/provider/job_category_provider.dart';
import 'package:provider/provider.dart';

class DropdownJobCategory extends StatelessWidget {
  const DropdownJobCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<JobCategoryProvider>(
      builder: (context, provider, child) {
        return DropdownButtonFormField<String>(
          menuMaxHeight: 200,
          initialValue: provider.selectedCategory,
          hint: Text(
            'Select Category',
            style: kManropeBodyText.copyWith(color: Colors.grey),
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.yellow,
                width: 2,
              ),
            ),
            fillColor: Colors.grey.shade200,
          ),
          items: [
            DropdownMenuItem<String>(
              value: null,
              child: Text('No Category'),
            ),
            ...provider.categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }),
          ],
          onChanged: (value) {
            provider.changeCategory(value);
          },
        );
      },
    );
  }
}