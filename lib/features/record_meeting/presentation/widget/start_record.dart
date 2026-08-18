import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';

class StartRecord extends StatelessWidget {
  const StartRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecordMeetingCubit, RecordMeetingState>(
      builder: (context, state) {
        final isActive =
            state is StartRecordMeeting ||
            state is PauseRecordMeeting ||
            state is ResumeRecordMeeting;
        final isFinishing = state is FinishingRecordState;
        final isPaused = state is PauseRecordMeeting;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: isActive || isFinishing
                  ? null
                  : context.read<RecordMeetingCubit>().startRecord,
              customBorder: const CircleBorder(),
              child: Container(
                width: 180,
                height: 180,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE53935),
                ),
                child: Icon(
                  isPaused
                      ? Icons.pause
                      : isActive
                      ? Icons.graphic_eq
                      : Icons.mic,
                  color: Colors.white,
                  size: 72,
                ),
              ),
            ),
            if (isActive || isFinishing) ...[
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton.filled(
                    onPressed: isFinishing
                        ? null
                        : context.read<RecordMeetingCubit>().finishRecord,
                    tooltip: 'Finish record',
                    icon: const Icon(Icons.stop),
                  ),
                  const SizedBox(width: 12),
                  IconButton.filled(
                    onPressed: isFinishing
                        ? null
                        : isPaused
                        ? context.read<RecordMeetingCubit>().resumeRecord
                        : context.read<RecordMeetingCubit>().pauseRecord,
                    tooltip: isPaused ? 'Resume' : 'Pause',
                    icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
