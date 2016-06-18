defmodule Regressions.I066ErrorContextTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "Issue https://github.com/pragdave/earmark/issues/66 1" do
    assert capture_io( :stderr, fn->
      Earmark.to_html ~s(`Hello\nWorld), %Earmark.Options{filename: "fn"}
    end) == "fn:1: warning: close pending \"`\", multiline inline code blocks are deprecated\n"
  end

  test "Issue https://github.com/pragdave/earmark/issues/66 2" do
    assert capture_io( :stderr, fn->
      Earmark.to_html ~s(And\n`Hello\nWorld)
    end) == "<no file>:2: warning: close pending \"`\", multiline inline code blocks are deprecated\n"
  end

  test "Issue https://github.com/pragdave/earmark/issues/66 3" do
    assert capture_io( :stderr, fn->
      Earmark.to_html ~s(* And\n* `Hello\n* World)
    end) == "<no file>:2: warning: close pending \"`\", multiline inline code blocks are deprecated\n"
  end
end
