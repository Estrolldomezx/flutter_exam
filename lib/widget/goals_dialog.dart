import 'package:flutter/material.dart';

import 'package:midterm_proj/models/model.dart';

class GoalDialog extends StatefulWidget {
  final Goals? goal; //Goal
  final Function(String name, String category, bool isExpense) onClickedDone;

  const GoalDialog({
    Key? key,
    this.goal,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _GoalDialogState createState() => _GoalDialogState();
}

class _GoalDialogState extends State<GoalDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final categoryController = TextEditingController();

  bool isChoose = true;

  @override
  void initState() {
    super.initState();

    if (widget.goal != null) {
      final goal = widget.goal!;

      nameController.text = goal.name;
      // categoryController.text = goal.category;
      // isExpense = goal.isExpense;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    // categoryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.goal != null;
    final title = isEditing ? 'Edit Goal' : 'Add Goal';

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://image.flaticon.com/icons/png/512/150/150275.png',
            fit: BoxFit.contain,
            height: 50,
          ),
          Container(
              padding: const EdgeInsets.all(8.0), child: Text('Add your Goals'))
        ],
      ),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 8),
              buildCategory(),
              SizedBox(height: 8),
              buildRadioButtons(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Name',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildCategory() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Category',
        ),
        keyboardType: TextInputType.text,
        validator: (category) => category != null && double.tryParse(category) == null
            ? 'Enter a valid category'
            : null,
        controller: categoryController,
      );

  // Widget buildDropdown() {
  //   return DropdownButton<String>(
  //     value: dropdownValue,
  //     icon: const Icon(Icons.arrow_downward),
  //     iconSize: 24,
  //     elevation: 16,
  //     style: const TextStyle(color: Colors.deepPurple),
  //     underline: Container(
  //       height: 2,
  //       color: Colors.deepPurpleAccent,
  //     ),
  //     onChanged: (String? newValue) {
  //       setState(() {
  //         dropdownValue = newValue!;
  //       });
  //     },
  //     items: <String>['One', 'Two', 'Free', 'Four']
  //         .map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList(),
  //   );
  // }

  Widget buildRadioButtons() => Column(
        children: [
          RadioListTile<bool>(
            title: Text('Categories'),
            value: true,
            groupValue: isChoose,
            onChanged: (value) => setState(() => isChoose = value!),
          ),
        ],
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          final category = categoryController.text;

          widget.onClickedDone(name, category, isChoose);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
