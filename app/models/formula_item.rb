class FormulaItem < ActiveRecord::Base

 belongs_to :item, :polymorphic => true
 belongs_to :formula
 validates_presence_of :item_id, :item_type
  
  scope :metrics, where(:item_type => 'Metric')
 
  def metric? 
    item_type == 'Metric'    
  end



end
