enum RecordMeetingAudioQuality {
  verySmall,
  smaller,
  balanced,
  highQuality,
  highVbr,
}

extension RecordMeetingAudioQualityX on RecordMeetingAudioQuality {
  String get label {
    switch (this) {
      case RecordMeetingAudioQuality.verySmall:
        return 'Very small';
      case RecordMeetingAudioQuality.smaller:
        return 'Smaller';
      case RecordMeetingAudioQuality.balanced:
        return 'Balanced';
      case RecordMeetingAudioQuality.highQuality:
        return 'High quality';
      case RecordMeetingAudioQuality.highVbr:
        return 'High VBR';
    }
  }

  String get estimatedSizePerHour {
    switch (this) {
      case RecordMeetingAudioQuality.verySmall:
        return '~22 MB/hour';
      case RecordMeetingAudioQuality.smaller:
        return '~29 MB/hour';
      case RecordMeetingAudioQuality.balanced:
        return '~43 MB/hour';
      case RecordMeetingAudioQuality.highQuality:
        return '~58 MB/hour';
      case RecordMeetingAudioQuality.highVbr:
        return '~60-120 MB/hour';
    }
  }

  List<String> get ffmpegAudioArguments {
    switch (this) {
      case RecordMeetingAudioQuality.verySmall:
        return const ['-b:a', '48k'];
      case RecordMeetingAudioQuality.smaller:
        return const ['-b:a', '64k'];
      case RecordMeetingAudioQuality.balanced:
        return const ['-b:a', '96k'];
      case RecordMeetingAudioQuality.highQuality:
        return const ['-b:a', '128k'];
      case RecordMeetingAudioQuality.highVbr:
        return const ['-q:a', '2'];
    }
  }
}

class RecordMeetingAudioConfig {
  const RecordMeetingAudioConfig._();

  static const defaultQuality = RecordMeetingAudioQuality.balanced;
}
