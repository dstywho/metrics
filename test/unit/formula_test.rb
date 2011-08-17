require 'test_helper'

class FormulaTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "parse" do
    f = "branch_coverage + line_coverage /2"
    formula_items = Formula.parse(f)  
    assert formula_items.length == 5
  end 
end
