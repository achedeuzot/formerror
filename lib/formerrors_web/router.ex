defmodule FormerrorsWeb.Router do
  use FormerrorsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {FormerrorsWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FormerrorsWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/formerror", Live.Step1, :step_1
  end

  # Other scopes may use custom stacks.
  # scope "/api", FormerrorsWeb do
  #   pipe_through :api
  # end
end
