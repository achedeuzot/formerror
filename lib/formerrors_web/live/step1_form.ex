defmodule FormerrorsWeb.Step1Form do
  @moduledoc """
  Form schema for the first step
  """
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:given_name, :string)
    field(:family_name, :string)
    field(:accepted_terms, :boolean)
    field(:profession, :string)
    field(:profession_other, :string)
    field(:user_expectation, :string)
  end

  @required_fields ~w(given_name family_name profession accepted_terms)a
  @optional_fields ~w(profession_other user_expectation)a
  @all_fields @required_fields ++ @optional_fields

  @profession_choices [
    {"student", "student"},
    {"professor", "professor"},
    {"other profession", "other"}
  ]

  def get_profession_choices, do: @profession_choices

  def get_profession(form) do
    if form.profession == "other" do
      "autre: #{form.profession_other}"
    else
      {choice_to_text, _key} =
        Enum.find(@profession_choices, fn {_text, key} ->
          key == form.profession
        end)

      choice_to_text |> String.capitalize()
    end
  end

  @doc false
  def changeset(schema, attrs) do
    schema
    |> cast(attrs, @all_fields)
    |> validate_required(:family_name, message: "Please enter your first name.")
    |> validate_required(:given_name, message: "Please enter your last name.")
    |> validate_required(:profession, message: "Please enter your profession.")
    |> validate_acceptance(:accepted_terms,
      message: "Please accept terms"
    )
    |> validate_length(:user_expectation, max: 16_384, message: "Votre message est trop long.")
    |> validate_length(:given_name,
      max: 32,
      message: "Your first name can't contain more than %{count} letters"
    )
    |> validate_length(:family_name,
      max: 32,
      message: "Your last name can't contain more than %{count} letters"
    )
    |> validate_inclusion(:profession, Enum.map(@profession_choices, fn {_name, key} -> key end))
    |> validate_other_profession
  end

  def validate_other_profession(changeset) do
    value = get_field(changeset, :profession)

    if value == "other" do
      validate_required(changeset, :profession_other, message: "Please specify your profession")
    else
      changeset
    end
  end
end
