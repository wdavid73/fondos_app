import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/shared/service/service.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';

class InputsWidget extends StatefulWidget {
  const InputsWidget({super.key});

  @override
  State<InputsWidget> createState() => _InputsWidgetState();
}

class _InputsWidgetState extends State<InputsWidget> {
  String _photoPath = 'no photo picked';
  String _takePhotoPath = 'no photo taked';
  // final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Map<String, Color> colors = {
      'red': Colors.red,
      'green': Colors.green,
      'blue': Colors.blue,
      'yellow': Colors.yellow,
      'orange': Colors.orange,
      'purple': Colors.purple,
      'pink': Colors.pink,
      'brown': Colors.brown,
      'grey': Colors.grey,
    };

    // final List<String> _selectedColors = [];

    void pickImage() async {
      final photoPath = await CameraGalleryServiceImpl().selectPhoto();
      if (photoPath == null) return null;
      setState(() => _photoPath = photoPath);
    }

    void takePhoto() async {
      final photoPath = await CameraGalleryServiceImpl().takePhoto();
      if (photoPath == null) return null;
      setState(() => _takePhotoPath = photoPath);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Inputs Widget"),
      ),
      body: SafeArea(
        child: Container(
          width: context.width,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _inputText(),
                const SizedBox(height: 10),
                _inputTextDisable(),
                const SizedBox(height: 10),
                _inputNumber(),
                const SizedBox(height: 10),
                _inputPassword(),
                const SizedBox(height: 10),
                _inputDropdown(colors),
                const SizedBox(height: 10),
                _inputMultiSelect(context),
                const SizedBox(height: 10),
                SizedBox(
                  width: context.width,
                  child: Text(
                    '"If you need pick only a month or year implement the package month_picker_dialog"',
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 10),
                _inputDatePicker(),
                const SizedBox(height: 10),
                _inputRangeDatePicker(),
                const SizedBox(height: 10),
                _inputPickerImage(pickImage, context),
                const SizedBox(height: 20),
                _inputTakePhoto(takePhoto, context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputTakePhoto(void Function() takePhoto, BuildContext context) {
    return Column(
      children: [
        if (_takePhotoPath != 'no photo taked')
          Container(
            width: context.wp(30),
            height: context.hp(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: Image.file(File(_takePhotoPath)).image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Take photo:"),
            const SizedBox(width: 50),
            IconButton.filled(
              onPressed: takePhoto,
              icon: Icon(
                Icons.camera_alt_rounded,
                color: ColorTheme.white,
              ),
              iconSize: context.dp(3.5),
            ),
          ],
        ),
        Text("Photo path: $_takePhotoPath"),
      ],
    );
  }

  Widget _inputPickerImage(void Function() pickImage, BuildContext context) {
    return Column(
      children: [
        if (_photoPath != 'no photo picked')
          Container(
            width: context.wp(30),
            height: context.hp(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: Image.file(File(_photoPath)).image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Image picker:"),
            const SizedBox(width: 50),
            IconButton.filled(
              onPressed: pickImage,
              icon: Icon(
                Icons.photo_library_outlined,
                color: ColorTheme.white,
              ),
              iconSize: context.dp(3.5),
            ),
          ],
        ),
        Text("Photo path: $_photoPath"),
      ],
    );
  }

  Row _inputRangeDatePicker() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Range DatePicker:"),
        const SizedBox(width: 50),
        Expanded(
          child: CustomRangeDatePickerField(
            hintText: "Select a date",
            label: "Date",
            helpText: "helptext",
            cancelText: "Cancelar",
            confirmText: "Confirmar",
          ),
        )
      ],
    );
  }

  Row _inputDatePicker() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("DatePicker:"),
        const SizedBox(width: 50),
        Expanded(
          child: CustomDatePickerField(
            hintText: "Select a date",
            label: "Date",
            helpText: "helptext",
            cancelText: "Cancelar",
            confirmText: "Confirmar",
          ),
        )
      ],
    );
  }

  Widget _inputMultiSelect(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Multiselect: "),
        const SizedBox(width: 50),
        Expanded(
          child: CustomMultiSelectField(
            // controller: _controller,
            hintText: "Select colors",
            label: "Multi Select colors",
            helperText: "Select multiple colors",
            items: ["Rojo", "Verde", "Azul"],
            selectedItems: [],
            onSelectedItemsChanged: (items) {},
            displayTextBuilder: (items) => items!.join(' | '),
            titleBuilder: (item) => Text(
              item,
              style: context.textTheme.bodyLarge,
            ),
          ),
        )
      ],
    );
  }

  Widget _inputDropdown(Map<String, Color> colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Select: "),
        const SizedBox(width: 50),
        Expanded(
          child: CustomDropdownFormField(
            /*label: "Label",*/
            /*helperText: "Texto de ayuda",*/
            /*errorMessage: "Error Message",*/
            /*prefixIcon: Icon(Icons.verified_user),*/
            options: colors.keys.toList(),
            itemBuilder: (option) {
              final colorName = option as String;
              final color = colors[colorName];
              return DropdownMenuItem(
                value: color,
                child: Text(colorName),
              );
            },
            onChanged: (val) {
              // print("color selected: $val");
            },
          ),
        )
      ],
    );
  }

  Widget _inputPassword() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Password:"),
        const SizedBox(width: 50),
        Expanded(
          child: CustomTextFormField(
            label: "Password",
            hint: "Hint",
            obscureText: true,
            prefixIcon: Icon(Icons.password),
          ),
        ),
      ],
    );
  }

  Widget _inputNumber() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Number:"),
        const SizedBox(width: 50),
        Expanded(
          child: CustomTextFormField(
            label: "Number with error",
            hint: "Hint",
            errorMessage: "Error Message",
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _inputTextDisable() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Text disable:"),
        const SizedBox(width: 50),
        Expanded(
          child: CustomTextFormField(
            label: "Text",
            hint: "Hint",
            enabled: false,
          ),
        ),
      ],
    );
  }

  Widget _inputText() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Text:"),
        const SizedBox(width: 50),
        Expanded(
          child: CustomTextFormField(
            label: "Text",
            hint: "Hint",
          ),
        ),
      ],
    );
  }
}
