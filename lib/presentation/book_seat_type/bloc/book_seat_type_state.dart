import 'package:cinema_booking/core/enum/type_seat.dart';
import 'package:cinema_booking/domain/entities/booking/booking_time_slot.dart';
import 'package:cinema_booking/domain/entities/movies/movies.dart';
import 'package:cinema_booking/domain/entities/show_time/time_slot.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_seat_type_state.freezed.dart';

@freezed
abstract class BookSeatTypeState with _$BookSeatTypeState {
  const factory BookSeatTypeState({
    MovieEntity? movie,
    TimeSlotEntity? selectedTimeSlot,
    BookTimeSlotEntity? bookTimeSlot,
    @Default(2) int seatCount,
    @Default(TypeSeat.king) TypeSeat selectedSeatType,
    @Default(false) bool isOpenBookSeatSlotScreen,
  }) = _BookSeatTypeState;
}
