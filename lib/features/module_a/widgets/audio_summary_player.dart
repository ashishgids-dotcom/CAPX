import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../core/theme/app_theme.dart';

/// Plays a pre-recorded ~1 minute audio summary in the user's chosen
/// dialect. Expects an asset (or remote URL) per language code, e.g.
/// assets/audio/module_a_summary_hi.mp3, module_a_summary_bho.mp3, etc.
/// Ship real recordings before release — this widget is fully wired but
/// will show a friendly error if the asset for a given language is missing.
class AudioSummaryPlayer extends StatefulWidget {
  final String languageCode;
  const AudioSummaryPlayer({super.key, required this.languageCode});

  @override
  State<AudioSummaryPlayer> createState() => _AudioSummaryPlayerState();
}

class _AudioSummaryPlayerState extends State<AudioSummaryPlayer> {
  final _player = AudioPlayer();
  bool _isLoading = false;
  bool _hasError = false;

  String get _assetPath => 'assets/audio/module_a_summary_${widget.languageCode}.mp3';

  Future<void> _togglePlay() async {
    if (_player.playing) {
      await _player.pause();
      setState(() {});
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      if (_player.audioSource == null) {
        await _player.setAsset(_assetPath);
      }
      await _player.play();
    } catch (_) {
      _hasError = true;
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            InkWell(
              onTap: _togglePlay,
              borderRadius: BorderRadius.circular(30),
              child: CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.royalBlue,
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Icon(
                        _player.playing ? Icons.pause_rounded : Icons.volume_up_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🔊 Listen to the 1-minute summary',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _hasError
                        ? 'Audio not available yet in this language.'
                        : 'In your selected dialect',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: _hasError ? AppColors.crimsonRed : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
