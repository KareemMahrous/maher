import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExamplesCubit>().fetchExamples();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example')),
      body: BlocBuilder<ExamplesCubit, ExamplesState>(
        builder: (context, state) {
          if (state is ExampleLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ExampleFailure) {
            return Center(child: Text(state.message));
          }
          if (state is ExampleSuccess) {
            return Center(child: Text('Example loaded: ${state.data.id}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
