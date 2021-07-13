defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking
  alias Flightex.Users.User

  def generate_report(dt1, dt2) do
    booking_list = build_booking_list(dt1, dt2)

    File.write("report-#{dt1}-#{dt2}.csv", booking_list)
  end

  defp build_booking_list(dt1, dt2) do
    BookingAgent.list_all()
    |> Map.values()
    |> Enum.filter(fn booking ->
      booking.complete_date >= dt1 &&
        booking.complete_date <= dt2
    end)
    |> Enum.map(&booking_to_string/1)
  end

  defp booking_to_string(%Booking{
         user_id: %User{cpf: cpf},
         local_origin: origin,
         local_destination: destination,
         complete_date: date
       }) do
    "#{cpf},#{origin},#{destination},#{date}\n"
  end
end
