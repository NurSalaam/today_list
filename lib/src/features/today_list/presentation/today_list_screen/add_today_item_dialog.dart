import 'package:flutter/material.dart';

class AddTodayItemDialog extends StatefulWidget {
  const AddTodayItemDialog({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddTodayItemDialogState createState() => _AddTodayItemDialogState();
}

class _AddTodayItemDialogState extends State<AddTodayItemDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = 'You sure this is necessary...?';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditingController.text.length),
      );
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Material(
        elevation: 24,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Add Today Item',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              TextField(
                autofocus: true,
                controller: _textEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, _textEditingController.text);
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showAddTodayItemDialog(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: TextFormField(
          autofocus: true,
          keyboardType: TextInputType.text,
          initialValue: "You sure this is necessary...?",
          decoration: InputDecoration(
            hintText: "You sure this is necessary...?",
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
      );
    },
  );
}
