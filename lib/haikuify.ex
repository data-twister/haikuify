defmodule Haikuify do
  @moduledoc """
  # Haikuify

  Generate Heroku-like memorable random names to use in your apps or anywhere else.
  """

  @adjectives Application.compile_env(:haikuify, :adjectives, ~w(
  autumn hidden bitter misty silent empty dry dark summer
  icy delicate quiet white cool spring winter patient
  twilight dawn crimson wispy weathered blue billowing
  broken cold damp falling frosty green long late lingering
  bold little morning muddy old red rough still small
  sparkling throbbing shy wandering withered wild black
  young holy solitary fragrant aged snowy proud floral
  restless divine polished ancient purple lively nameless
))
  @nouns Application.compile_env(:haikuify, :nouns, ~w(
   waterfall river breeze moon rain wind sea morning
   snow lake sunset pine shadow leaf dawn glitter forest
   hill cloud meadow sun glade bird brook butterfly
   bush dew dust field fire flower firefly feather grass
   haze mountain night pond darkness snowflake silence
   sound sky shape surf thunder violet water wildflower
   wave water resonance sun wood dream cherry tree fog
   frost voice paper frog smoke star
))

  @doc """
  Generate a memorable name.

  `token` is the first parameter, and sets either a string suffix or the range for the token (i.e. the number) from 0 to n.
  Defaults to `9999`.

  `delimiter` is the second parameter, and it's the string that joins the sections.
  Defaults to `"-"`.

  ## Examples

      # Default
      iex> Haikuify.build # => "morning-star"

      # Token range
      iex> Haikuify.build(100) # => "summer-dawn-24"

      # Don't include the token
      iex> Haikuify.build(0) # => "ancient-frost"

      # Use a different delimiter
      iex> Haikuify.build(9999, ".") # => "frosty.leaf.8347"

      # No token, no delimiter
      iex> Haikuify.build(0, "") # => "twilightbreeze"

      # Text token, no delimiter
      iex> Haikuify.build("suffix", "") # => "twilightbreezesuffix"

      # Text token, different delimiter
      iex> Haikuify.build("suffix", ".") # => "frosty.leaf.suffix"

      # Text token with spaces, different delimiter
      iex> Haikuify.build("end of suffix", ".") # => "frosty.leaf.and.of.suffix"
  """

  def build(token, args, delimiter) do
    :rand.seed(:exsplus)
    token = token(token, args, delimiter)

    [@adjectives, @nouns]
    |> Enum.map(&sample/1)
    |> Enum.concat(List.wrap(token))
    |> Enum.join(delimiter)
  end

  @spec build(integer, String.t()) :: String.t()
  def build(max, delimiter) when is_integer(max) do
    :rand.seed(:exsplus)

    [@adjectives, @nouns]
    |> Enum.map(&sample/1)
    |> Enum.concat(List.wrap(token(max, "", "")))
    |> Enum.join(delimiter)
  end

  @spec build(String.t(), String.t()) :: String.t()
  def build(token, delimiter) when is_bitstring(token) do
    :rand.seed(:exsplus)
    token = token(token, " ", delimiter)

    [@adjectives, @nouns]
    |> Enum.map(&sample/1)
    |> Enum.concat(List.wrap(token))
    |> Enum.join(delimiter)
  end

  @spec build(integer, String.t()) :: String.t()
  def build(max) when is_integer(max) do
    :rand.seed(:exsplus)
    delimiter = Application.get_env(:haikuify, :delimiter) || "-"

    [@adjectives, @nouns]
    |> Enum.map(&sample/1)
    |> Enum.concat(List.wrap(token(max, "", "")))
    |> Enum.join(delimiter)
  end

  @spec build(string, String.t()) :: String.t()
  def build(delimiter \\ "-") when is_bitstring(delimiter) do
    :rand.seed(:exsplus)

    [@adjectives, @nouns]
    |> Enum.map(&sample/1)
    |> Enum.concat(List.wrap(token()))
    |> Enum.join(delimiter)
  end

  def token(params, args, separator) when is_integer(params) do
    token =
      case params do
        x when x > 0 -> random(params)
        0 -> nil
        _ -> random(9999)
      end
  end

  def token(params, args, separator) when is_bitstring(params) do
    params |> String.replace(args, separator)
  end

  defp token() do
    nil
  end

  @spec random(integer) :: integer
  defp random(range) when range > 0, do: :rand.uniform(range)

  @spec sample([any]) :: any
  defp sample(array), do: Enum.random(array)
end
