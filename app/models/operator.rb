class Operator < ActiveRecord::Base
  has_many :formula_items, :as => :item
  def escaped
    escape_string = name.map{|char| "\\" + char }.join
  end
end
