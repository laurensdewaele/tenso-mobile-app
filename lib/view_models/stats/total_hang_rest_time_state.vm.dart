import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/widgets/stats/total_hang_rest_time/stats_filter.dart';
import 'package:tenso_app/widgets/stats/total_hang_rest_time/total_hang_rest_time_chart.dart';

class TotalHangRestTimeViewModelState {
  const TotalHangRestTimeViewModelState(
      {@required this.startDate,
      @required this.endDate,
      @required this.dateRange,
      @required this.rangeFilter,
      @required this.hangData,
      @required this.restData,
      @required this.selectedDate,
      @required this.hangSecondsForSelectedDate,
      @required this.restSecondsForSelectedDate,
      @required this.filteredLabel,
      @required this.filteredWorkout});

  final Label filteredLabel;
  final Workout filteredWorkout;
  final DateTime startDate;
  final DateTime endDate;
  final List<DateTime> dateRange;
  final RangeFilter rangeFilter;
  final List<TotalHangRestTimeData> hangData;
  final List<TotalHangRestTimeData> restData;
  final DateTime selectedDate;
  final int hangSecondsForSelectedDate;
  final int restSecondsForSelectedDate;

  TotalHangRestTimeViewModelState copyWith({
    DateTime startDate,
    DateTime endDate,
    List<DateTime> dateRange,
    Nullable<RangeFilter> rangeFilter,
    List<TotalHangRestTimeData> hangData,
    List<TotalHangRestTimeData> restData,
    DateTime selectedDate,
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
      selectedDate: selectedDate ?? this.selectedDate,
      hangSecondsForSelectedDate:
          hangSecondsForSelectedDate ?? this.hangSecondsForSelectedDate,
      restSecondsForSelectedDate:
          restSecondsForSelectedDate ?? this.restSecondsForSelectedDate,
      rangeFilter: rangeFilter == null ? this.rangeFilter : rangeFilter.value,
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
          rangeFilter == other.rangeFilter &&
          hangData == other.hangData &&
          restData == other.restData &&
          selectedDate == other.selectedDate &&
          hangSecondsForSelectedDate == other.hangSecondsForSelectedDate &&
          restSecondsForSelectedDate == other.restSecondsForSelectedDate;

  @override
  int get hashCode =>
      filteredLabel.hashCode ^
      filteredWorkout.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      dateRange.hashCode ^
      rangeFilter.hashCode ^
      hangData.hashCode ^
      restData.hashCode ^
      selectedDate.hashCode ^
      hangSecondsForSelectedDate.hashCode ^
      restSecondsForSelectedDate.hashCode;
}
