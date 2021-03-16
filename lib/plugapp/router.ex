defmodule Plugapp.Router do
  use Plug.Router
  alias Plugapp.Stubs

  @template_dir "lib/plugapp/templates"

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["text/*"],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  get "/" do
    render(conn, "index.html", portfolio: Stubs.portfolio_entries())
  end

  get "/contact" do
    render(conn, "contact.html")
  end

  get "/ping" do
    send_resp(conn, 200, "pong")
  end

  post "/contact" do
    Stubs.submit_contact(conn.params)
    render_json(conn, %{message: "we received your message and will reply soon"})
  end

  match _ do
    send_resp(conn, 404, "404 Not Found")
  end

  defp render(%{status: status} = conn, template, assigns \\ []) do
    body =
      @template_dir
      |> Path.join(template)
      |> String.replace_suffix(".html", ".html.eex")
      |> EEx.eval_file(assigns)

    send_resp(conn, status || 200, body)
  end

  defp render_json(%{status: status} = conn, data) do
    body = Jason.encode!(data)
    send_resp(conn, status || 200, body)
  end
end
