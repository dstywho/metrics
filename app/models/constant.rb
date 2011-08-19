class Constant < ActiveRecord::Base
  alias_attribute :name, :value
  has_many :formula_items, :as => :item
  
end
