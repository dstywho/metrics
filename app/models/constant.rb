class Constant < ActiveRecord::Base
  has_many :formula_items, :as => :item
end
