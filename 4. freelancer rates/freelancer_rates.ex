defmodule FreelancerRates do
  @daily_rate 8.0
  @monthly_billable_days 22
  def daily_rate(hourly_rate), do: hourly_rate * @daily_rate

  def apply_discount(before_discount, discount) do
    before_discount * (100 - discount) / 100
  end

  def monthly_rate(hourly_rate, discount) do
    total_undiscounted = daily_rate(hourly_rate) * @monthly_billable_days

    total_undiscounted
    |> apply_discount(discount)
    |> ceil()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_rate_discounted =
      hourly_rate
      |> daily_rate()
      |> apply_discount(discount)

    total_days = budget / daily_rate_discounted
    Float.floor(total_days, 1)
  end
end
