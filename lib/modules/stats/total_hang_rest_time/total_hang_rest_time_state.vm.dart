import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/stats/total_hang_rest_time/total_hang_rest_time_chart.dart';

class TotalHangRestTimeViewModelState {
  const TotalHangRestTimeViewModelState(
      {@required this.startDate,
      @required this.endDate,
      @required this.dateRange,
      @required this.hangData,
      @required this.restData,
      @required this.selectedDateOnChart,
      @required this.hangSecondsForSelectedDate,
      @required this.restSecondsForSelectedDate,
      @required this.filteredLabel,
      @required this.filteredWorkout});

  final Label filteredLabel;
  final Workout filteredWorkout;
  final DateTime startDate;
  final DateTime endDate;
  final List<DateTime> dateRange;
  final List<TotalHangRestTimeData> hangData;
  final List<TotalHangRestTimeData> restData;
  final DateTime selectedDateOnChart;
  final int hangSecondsForSelectedDate;
  final int restSecondsForSelectedDate;

  TotalHangRestTimeViewModelState copyWith({
    DateTime startDate,
    DateTime endDate,
    List<DateTime> dateRange,
    List<TotalHangRestTimeData> hangData,
    List<TotalHangRestTimeData> restData,
    DateTime selectedDateOnChart,
    int hangSecondsForSelectedDate,
    int restSecondsForSelectedDate,
    Nullable<Label> filteredLabel,
    Nullable<Workout> filteredWorkout,
  }) {
    return new TotalHangRestTimeViewModelState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dateRange: dateRange ?? this.dateRange,
      hangData: hangData ?? this.hangData,
      restData: restData ?? this.restData,
      selectedDateOnChart: selectedDateOnChart ?? this.selectedDateOnChart,
      hangSecondsForSelectedDate:
          hangSecondsForSelectedDate ?? this.hangSecondsForSelectedDate,
      restSecondsForSelectedDate:
          restSecondsForSelectedDate ?? this.restSecondsForSelectedDate,
      filteredWorkout: filteredWorkout == null
          ? this.filteredWorkout
          : filteredWorkout.value,
      filteredLabel:
          filteredLabel == null ? this.filteredLabel : filteredLabel.value,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalHangRestTimeViewModelState &&
          runtimeType == other.runtimeType &&
          filteredLabel == other.filteredLabel &&
          filteredWorkout == other.filteredWorkout &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          dateRange == other.dateRange &&
          hangData == other.hangData &&
          restData == other.restData &&
          selectedDateOnChart == other.selectedDateOnChart &&
          hangSecondsForSelectedDate == other.hangSecondsForSelectedDate &&
          restSecondsForSelectedDate == other.restSecondsForSelectedDate;

  @override
  int get hashCode =>
      filteredLabel.hashCode ^
      filteredWorkout.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      dateRange.hashCode ^
      hangData.hashCode ^
      restData.hashCode ^
      selectedDateOnChart.hashCode ^
      hangSecondsForSelectedDate.hashCode ^
      restSecondsForSelectedDate.hashCode;
}
