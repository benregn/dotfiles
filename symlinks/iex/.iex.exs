timestamp = fn ->
  {_date, {hour, minute, _second}} = :calendar.local_time
  [hour, minute]
  |> Enum.map(&(String.pad_leading(Integer.to_string(&1), 2, "0")))
  |> Enum.join(":")
end

IEx.configure(
  colors: [
    syntax_colors: [
      number: :light_yellow,
      atom: :light_cyan,
      string: :light_black,
      boolean: :red,
      nil: [:magenta, :bright],
    ],
    ls_directory: :cyan,
    ls_device: :yellow,
    doc_code: :green,
    doc_inline_code: :magenta,
    doc_headings: [:cyan, :underline],
    doc_title: [:cyan, :bright, :underline],
  ],
  default_prompt:
    "#{IO.ANSI.green}%prefix#{IO.ANSI.reset} " <>
    "[#{IO.ANSI.magenta}#{timestamp.()}#{IO.ANSI.reset} " <>
    ":: #{IO.ANSI.cyan}%counter#{IO.ANSI.reset}] >",
  alive_prompt:
    "#{IO.ANSI.green}%prefix#{IO.ANSI.reset} " <>
    "(#{IO.ANSI.yellow}%node#{IO.ANSI.reset}) " <>
    "[#{IO.ANSI.magenta}#{timestamp.()}#{IO.ANSI.reset} " <>
    ":: #{IO.ANSI.cyan}%counter#{IO.ANSI.reset}] >",
  history_size: 50,
  inspect: [
    pretty: true,
    limit: :infinity,
    width: 80
  ],
  width: 80
)

defmodule FunctionClause do
  @moduledoc """
  Format function clauses using Exception.blame/3
  """

  @doc """
  Given a `module`, `function`, and `args` see
  if that function clause would match or not match.
  This is useful for helping diagnose function
  clause errors when many clauses are generated
  at compile time.
  """
  @spec match(module(), atom(), list(any)) :: :ok | no_return()
  def match(module, function, args) do
    case Exception.blame_mfa(module, function, args) do
      {:ok, kind, clauses} ->
        formatted_clauses(function, kind, clauses, &blame_match/2)

      :error ->
        raise ArgumentError,
              "Function #{inspect(module)}.#{inspect(function)}/#{length(args)} " <>
                "is not known."
    end
  end

  defp formatted_clauses(function, kind, clauses, ast_fun) do
    format_clause_fun = fn {args, guards} ->
      code = Enum.reduce(guards, {function, [], args}, &{:when, [], [&2, &1]})
      "    #{kind} " <> Macro.to_string(code, ast_fun) <> "\n"
    end

    clauses
    |> Enum.map(format_clause_fun)
    |> Enum.join()
    |> IO.puts()
  end

  defp blame_match(%{match?: true, node: node}, _),
    do: Macro.to_string(node)

  defp blame_match(%{match?: false, node: node}, _),
    do: IO.ANSI.red() <> Macro.to_string(node) <> IO.ANSI.reset()

  defp blame_match(_, string), do: string
end

defmodule KEx do
  def pbcopy(term) do
    text =
      if is_binary(term) do
        term
      else
        inspect(term, limit: :infinity, pretty: true)
      end

    port = Port.open({:spawn, "/usr/bin/pbcopy"}, [:binary])

    true = Port.command(port, text)
    true = Port.close(port)

    term
  end
end
