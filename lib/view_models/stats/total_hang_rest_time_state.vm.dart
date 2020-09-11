import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/widgets/stats/total_hang_rest_time/stats_filter.dart';
import 'package:tenso_app/widgets/stats/total_hang_rest_time/total_hang_rest_time_chart.dart';

class TotalHangRestTimeViewModelState {
  const TotalHangRestTimeViewModelState({
    @required this.startDate,
    @required this.endDate,
    @required this.dateRange,
    @required this.rangeFilter,
    @required this.hangData,
    @required this.restData,
    @required this.selectedDate,
    @required this.hangSecondsForSelectedDate,
    @required this.restSecondsForSelectedDate,
  });

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
  }) {
    if ((startDate == null || identical(startDate, this.startDate)) &&
        (endDate == null || identical(endDate, this.endDate)) &&
        (dateRange == null || identical(dateRange, this.dateRange)) &&
        (rangeFilter == null || identical(rangeFilter, this.rangeFilter)) &&
        (hangData == null || identical(hangData, this.hangData)) &&
        (restData == null || identical(restData, this.restData)) &&
        (selectedDate == null || identical(selectedDate, this.selectedDate)) &&
        (hangSecondsForSelectedDate == null ||
            identical(
                hangSecondsForSelectedDate, this.hangSecondsForSelectedDate)) &&
        (restSecondsForSelectedDate == null ||
            identical(
                restSecondsForSelectedDate, this.restSecondsForSelectedDate))) {
      return this;
    }

    return new TotalHangRestTimeViewModelState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dateRange: dateRange ?? this.dateRange,
      rangeFilter: rangeFilter == null ? this.rangeFilter : rangeFilter.value,
      hangData: hangData ?? this.hangData,
      restData: restData ?? this.restData,
      selectedDate: selectedDate ?? this.selectedDate,
      hangSecondsForSelectedDate:
          hangSecondsForSelectedDate ?? this.hangSecondsForSelectedDate,
      restSecondsForSelectedDate:
          restSecondsForSelectedDate ?? this.restSecondsForSelectedDate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalHangRestTimeViewModelState &&
          runtimeType == other.runtimeType &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          dateRange == other.dateRange &&
          rangeFilter == other.rangeFilter &&
          listEquals(hangData, other.hangData) &&
          listEquals(restData, other.restData) &&
          selectedDate == other.selectedDate &&
          hangSecondsForSelectedDate == other.hangSecondsForSelectedDate &&
          restSecondsForSelectedDate == other.restSecondsForSelectedDate;

  @override
  int get hashCode =>
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
