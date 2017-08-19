defmodule PhoenixElmWeb.Router do
  use PhoenixElmWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", PhoenixElmWeb do
    pipe_through :browser

    get "/", PageController, :index
  end
end
