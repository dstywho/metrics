class FormulaReport < ActiveRecord::Base
  belongs_to :formula
  belongs_to :report
end
