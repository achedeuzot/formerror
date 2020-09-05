defmodule FormerrorsWeb.Live.Step1 do
  @moduledoc """
  This modules is used for the onboarding wizard steps
  """
  use FormerrorsWeb, :live_view

  alias FormerrorsWeb.Step1Form

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(changeset: Step1Form.changeset(%Step1Form{}, %{}))
     |> assign(page_title: "Welcome !")}
  end

  def handle_event("validate", %{"step1_form" => params}, socket) do
    changeset =
      Step1Form.changeset(%Step1Form{}, params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"step1_form" => params}, socket) do
    changeset = Step1Form.changeset(%Step1Form{}, params)

    if changeset.valid? do
      form = Ecto.Changeset.apply_changes(changeset)

      with {:ok, _user} <- update_user(%{}, form) do
        {:noreply,
         socket
         |> put_flash(:success, "Your account was updated.")
         |> redirect(to: Routes.page_path(FormerrorsWeb.Endpoint, :index))}
      else
        {:error, %Ecto.Changeset{}} ->
          {:noreply,
           socket
           |> put_flash(:error_account_update, "An error happend.")
           |> assign(changeset: Map.put(changeset, :action, :insert))}
      end
    else
      {:noreply, assign(socket, changeset: Map.put(changeset, :action, :insert))}
    end
  end

  defp update_user(_user, _form) do
    {:ok, %{}}
  end
end
