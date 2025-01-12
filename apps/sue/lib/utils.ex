defmodule Sue.Utils do
  @spec tokenize(String.t()) :: [String.t()]
  def tokenize(args) do
    cond do
      String.contains?(args, "\n") -> String.split(args, "\n")
      String.contains?(args, ",") -> String.split(args, ",", trim: true)
      true -> String.split(args, " ")
    end
  end

  @spec contains?(Enumerable.t(), any()) :: boolean()
  def contains?(enum, item) do
    item in enum
  end

  def unique_string() do
    ("Reference<" <> inspect(make_ref()))
    |> String.trim_trailing(">")
  end

  def tmp_file_name(suffix) when is_bitstring(suffix) do
    prefix = "#{:os.getpid()}-#{random_string()}-"
    prefix <> suffix
  end

  def random_string do
    Integer.to_string(rand_uniform(0x100000000), 36) |> String.downcase()
  end

  if :erlang.system_info(:otp_release) >= '18' do
    defp rand_uniform(num) do
      :rand.uniform(num)
    end
  else
    defp rand_uniform(num) do
      :random.uniform(num)
    end
  end
end
