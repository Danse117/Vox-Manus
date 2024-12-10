import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// Separate widget for translating text to sign language
class TextModeWidget extends StatefulWidget {
  const TextModeWidget({super.key});

  @override
  State<TextModeWidget> createState() => _TextModeWidgetState();
}

class _TextModeWidgetState extends State<TextModeWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _handleTranslate() {
    String textToTranslate = _textController.text;
    print('Translating: $textToTranslate');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Enter text to translate to sign language',
              border: OutlineInputBorder(),
              fillColor: AppTheme.colors.darkLightBackgroundColor,
              filled: true,
            ),
            style: TextStyle(color: AppTheme.colors.darkBackgroundColor),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _handleTranslate,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.colors.darkBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(
              'Translate',
              style: TextStyle(
                color: AppTheme.colors.primaryColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
