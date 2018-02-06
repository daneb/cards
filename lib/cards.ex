defmodule Cards do
  @moduledoc """
   Provides methods for creating and handling a deck of cards
  """

  #  Implicit return - auto returns
  # IEX - interactive elixir shell
  # iex - doesn't auto-reload (recompile)

  @doc """
    Returns a list of representing a deck of playing cards
  """
  def create_deck do
    # Double quotes for all strings
    # [] .<- is a list
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # List comprehension
    # The comprehension is a mapping function (put into a new array)
    for suit <- suits, value <- values do
        "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    # arity = number of arguments
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples

        iex(1)> deck = Cards.create_deck
        iex(2)> Cards.contains?(deck, "Ace of Spades")
        true

  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
  Divides a deck into a hand and the remainder of the deck. The `hand_size` argument indicates how many cards
  should be in the hand.

  ## Examples

      iex(1)> deck = Cards.create_deck
      iex(2)> {hand, deck} = Cards.deal(deck, 1)
      iex(3)> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    # Returns a Tuple
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    # Used erlang to turn an object into a binary
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    # { status, binary } = File.read(filename)

    # Now will pattern match here
    # _reason (_ means ignore second match)
    case File.read(filename) do
      { :ok, binary } -> :erlang.binary_to_term(binary)
      { :error, _reason } -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    # Pipe operator - for chain of method calls
    # deck = Cards.create_deck
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    # Pipe needs consistent first argument of the next function
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)

  end

  # Pattern matching is Elixir replacement for variable assignment
  # Pattern matches work with matching data structures on either side of the equality

  # color = "red"
  # This is not assignment. It is pattern matching.
  # Because color is not assigned, it will take the value red.

  # ["red", color] = ["green", "blue"]
  # Left-hand if hardcoded must match right hand side.

  # array - standard sequential block of contigous memory
  # linked list (LIST) - sequential block of unordered memory (great for inserts and deletes)
  # tutple -composite data types with fixed number of elements (without keys)

  # Elixir gets transpiled to Erlang.
  # Erlang compiled and executes in BEAM
  # Erlang - fantastic for telecoms (fault-tolerant, distributed transactions, concurrent)
  # BEAM - like JVM

  # IF is a code smell.
  # :ok = atom. Used throughout elixir used for control flow

  # Mix
  # mix deps.get

  # Maps:
  # Collection of key value-pair
  # We never mutate data, always create a new data structure

  # How to update a Map
  # iex(11)> colors
  # %{primary: "red"}
  # iex(12)> %{ colors | primary: "blue" }
  # %{primary: "blue"}

  # Keyword Lists
  # Combination of Tuple and Maps
  # iex(15)> colors = [{:primary, "red"}, {:secondary, "green"}]
  # [primary: "red", secondary: "green"]
  # iex(16)> colors[:primary]
  # "red"
  # iex(17)> colors[:secondary]
  # "green"

  # Maps only have one property
  # Keyword list allows non-unique properties (ecto uses keyword list)




end
