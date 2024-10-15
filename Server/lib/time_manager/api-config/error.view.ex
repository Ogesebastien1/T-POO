defmodule TimeManagerWeb.ErrorView do
  def render("404.json", _assigns) do
    %{errors: %{detail: "Resource not found"}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal server error"}}
  end

  def render("401.json", :invalid_password) do
    %{errors: %{detail: "Unauthorized", reason: :invalid_password}}
  end

  def render("401.json", _assigns) do
    %{errors: %{detail: "Unauthorized"}}
  end

  def render("403.json", _assigns) do
    %{errors: %{detail: "Forbidden"}}
  end

  def render("422.json", %{changeset: changeset}) do
    errors =
      Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
        Enum.reduce(opts, msg, fn {key, value}, acc ->
          String.replace(acc, "%{#{key}}", to_string(value))
        end)
      end)

    %{errors: errors}
  end

  def render("400.json", %{message: message}) do
    %{errors: %{detail: message}}
  end
end
