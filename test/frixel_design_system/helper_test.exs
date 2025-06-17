defmodule FrixelDesignSystem.HelperTest do
  alias FrixelDesignSystem.Helper
  use ComponentCase

  describe "format_text" do
    test "when text is nil" do
      # Given, When
      {:safe, result_wanted} = Helper.format_text(nil)

      # Then
      assert result_wanted == ""
    end
  end
end
