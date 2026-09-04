import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

/// AudioPromptWidget — Interactive speaker icon button that triggers spoken voice guidance.
class AudioPromptWidget extends StatefulWidget {
  final String textToSpeak;
  final VoidCallback? onPlay;

  const AudioPromptWidget({
    super.key,
    required this.textToSpeak,
    this.onPlay,
  });

  @override
  State<AudioPromptWidget> createState() => _AudioPromptWidgetState();
}

class _AudioPromptWidgetState extends State<AudioPromptWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _triggerAudio() {
    setState(() => _isPlaying = true);
    _controller.repeat(reverse: true);
    widget.onPlay?.call();

    // Reset animation after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _controller.stop();
        _controller.reset();
        setState(() => _isPlaying = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _triggerAudio,
      borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.spaceM),
        decoration: BoxDecoration(
          color: _isPlaying ? AppColors.secondaryContainer : AppColors.primaryContainer,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.15).animate(_controller),
          child: Icon(
            _isPlaying ? Icons.volume_up : Icons.volume_up_outlined,
            size: AppDimensions.iconLarge,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
