defmodule TimeManager.TimeTracking.Infrastructure.ClockPresenter do
  @self __MODULE__
  use TimeManagerWeb, :view

  alias TimeManager.TimeTracking.ClockModel

  def present_clock(%{clock: %ClockModel{} = clock}) do
    %{
      id: clock.id,
      status: clock.status,
      user_id: clock.user_id,
      time: clock.time
    }
  end

  def present_clocks(%{clocks: clocks}) do
    %{data: for(clock <- clocks, do: present_clock(%{clock: clock}))}
  end

  def render_result(conn, result, status \\ :ok)

  def render_result(conn, result, status) when is_list(result) do
    conn
    |> put_status(status)
    |> put_view(@self)
    |> render(:present_clocks, clocks: result)
  end

  def render_result(conn, result, status) do
    conn
    |> put_status(status)
    |> put_view(@self)
    |> render(:present_clock, clock: result)
  end

  def render_error(conn, template, status) do
    conn
    |> put_status(status)
    |> put_view(TimeManagerWeb.ErrorView)
    |> render(template)
  end
end
