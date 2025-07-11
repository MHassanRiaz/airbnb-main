class BookingPaymentsController < ApplicationController
  def create
    @property = Property.find(booking_payments_params[:property_id])

    checkin = Date.parse(booking_payments_params[:checkin_date])
    checkout = Date.parse(booking_payments_params[:checkout_date])

    # Check for ANY overlapping reservation (not just by current user)
    overlapping_reservation = Reservation.where(property_id: @property.id)
      .where("checkin_date < ? AND checkout_date > ?", checkout, checkin)
      .exists?

    if overlapping_reservation
      flash[:alert] = "Sorry, the property is already reserved for the selected dates."
      redirect_to property_path(@property) and return
    end

    # Proceed to create reservation and payment
    reservation = Reservation.create!(
      user_id: current_user.id,
      property_id: @property.id,
      checkin_date: checkin,
      checkout_date: checkout
    )

    Payment.create!(
      reservation_id: reservation.id,
      per_night: @property.price,
      base_fare: Money.from_amount(BigDecimal(booking_payments_params[:base_fare])),
      service_fee: Money.from_amount(BigDecimal(booking_payments_params[:service_fee])),
      total_amount: Money.from_amount(BigDecimal(booking_payments_params[:total_amount]))
    )

    flash[:notice] = "Booking successful (Stripe bypassed)"
    redirect_to root_path
  end

  private

  def booking_payments_params
    params.permit(:property_id, :checkin_date, :checkout_date, :base_fare, :service_fee, :total_amount)
  end
end
