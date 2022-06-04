defmodule GuessTheNumberWeb.Live.GuessTheNumberLive do
  use Phoenix.LiveView, layout: {GuessTheNumberWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, Keyword.merge([score: 0], initial_state()))}
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    {status, message, score} =
      score_guess(String.to_integer(guess), socket.assigns.score, socket.assigns.solution)

    {
      :noreply,
      assign(socket, message: message, score: score, status: status)
    }
  end

  def handle_event("reset", _, socket) do
    {:noreply, assign(socket, initial_state())}
  end

  defp score_guess(guess, score, solution) do
    {tip, score} =
      cond do
        guess < solution ->
          {"More!", score - 1}

        guess > solution ->
          {"Less!", score - 1}

        true ->
          {"Right!", score + 2}
      end

    cond do
      score >= 5 ->
        {:won, "You WON!", score}

      score <= -5 ->
        {:lost, "You LOST!", score}

      true ->
        {:continue, tip, score}
    end
  end

  defp initial_state do
    [message: "Make a guess:", solution: Enum.random(1..10), status: :continue]
  end

  def render(assigns) do
    ~H"""
      <h2>Reach 5 before you reach -5!</h2>
      <h1>Your score: <%= @score %></h1>
      <h2>
        <%= @message %>
      </h2>
      <%= if @status == :continue do %>
        <h2>
          <%= for n <- 1..10 do %>
            <a href="#" phx-click="guess" phx-value-number= {n} ><%= n %></a>
          <% end %>
        </h2>
        <button phx-click="reset">Reset</button>
      <% end %>
    """
  end
end
