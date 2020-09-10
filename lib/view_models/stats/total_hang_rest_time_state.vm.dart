import 'package:flutter/cupertino.dart';
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
  });

  final DateTime startDate;
  final DateTime endDate;
  final List<DateTime> dateRange;
  final RangeFilter rangeFilter;
  final List<TotalHangRestTimeData> hangData;
  final List<TotalHangRestTimeData> restData;

  TotalHangRestTimeViewModelState copyWith({
    DateTime startDate,
    DateTime endDate,
    List<DateTime> dateRange,
    Nullable<RangeFilter> rangeFilter,
    List<TotalHangRestTimeData> hangData,
    List<TotalHangRestTimeData> restData,
  }) {
    if ((startDate == null || identical(startDate, this.startDate)) &&
        (endDate == null || identical(endDate, this.endDate)) &&
        (dateRange == null || identical(dateRange, this.dateRange)) &&
        (rangeFilter == null || identical(rangeFilter, this.rangeFilter)) &&
        (hangData == null || identical(hangData, this.hangData)) &&
        (restData == null || identical(restData, this.restData))) {
      return this;
    }

    return new TotalHangRestTimeViewModelState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dateRange: dateRange ?? this.dateRange,
      rangeFilter: rangeFilter == null ? this.rangeFilter : rangeFilter.value,
      hangData: hangData ?? this.hangData,
      restData: restData ?? this.restData,
    );
  }
}
