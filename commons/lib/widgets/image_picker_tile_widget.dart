
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImagePickerTileWidget extends StatefulWidget {
  final String title;
  final ValueChanged<PlatformFile> onChanged;
  const ImagePickerTileWidget({
    Key? key,
    required this.title,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ImagePickerTileWidgetState createState() => _ImagePickerTileWidgetState();
}

class _ImagePickerTileWidgetState extends State<ImagePickerTileWidget> {
  bool _picked = false;

  _getImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        setState(() {
          widget.onChanged.call(result.files.single);
          _picked = true;
        });
      } else
        print('Nenhuma foto selecionada');
    } catch (e) {
      print('Ocorreu um error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title),
      leading: Icon(
        Icons.upload_rounded,
      ),
      trailing:
          _picked ? Text('Foto escolhida') : Text('Toque para enviar foto'),
      onTap: _getImage,
    );
  }
}
