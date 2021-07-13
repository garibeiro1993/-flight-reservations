# Este teste é opcional, mas vale a pena tentar e se desafiar 😉

defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case, async: true

  import Flightex.Factory

  alias Flightex.Bookings.Report

  describe "generate_report/2" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when called, return the content" do
      params =
        build_list(3, :booking,
          user_id: build(:users, cpf: 303_030_303),
          complete_date: ~N[2021-09-07 03:05:00]
        )

      Enum.each(params, &Flightex.create_or_update_booking/1)

      content =
        "303030303,Brasilia,Bananeiras,2021-09-07 03:05:00\n303030303,Brasilia,Bananeiras,2021-09-07 03:05:00\n303030303,Brasilia,Bananeiras,2021-09-07 03:05:00\n"

      dt1 = ~N[2021-09-06 03:05:00]
      dt2 = ~N[2021-09-08 03:05:00]

      assert :ok = Report.generate_report(dt1, dt2)

      {_ok, file} = File.read("report-2021-09-06 03:05:00-2021-09-08 03:05:00.csv")

      assert content =~ file
    end
  end
end
