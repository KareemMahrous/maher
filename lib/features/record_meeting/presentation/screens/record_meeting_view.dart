import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../widget/widget.dart';

@RoutePage()
class RecordMeetingView extends StatelessWidget {
  const RecordMeetingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecordMeetingCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Record Meeting')),
        body: BlocConsumer<RecordMeetingCubit, RecordMeetingState>(
          listener: (context, state) {
            if (state is FinishRecordMeeting) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              return;
            }

            if (state is ErrorRecordMeetingState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isFinishing = state is FinishingRecordState;

            return Stack(
              children: [
                const Center(child: StartRecord()),
                if (isFinishing)
                  const Positioned.fill(
                    child: ColoredBox(
                      color: Color(0x99000000),
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
