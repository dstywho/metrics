class Formula < ActiveRecord::Base

  attr_accessor :formula 

  has_many :formula_items
  validate :formula_is_valid

  def create_or_update
    if @formula.nil? || @is_in_transaction
      super
    else
      store_with_formula_items
    end
  end

  def self.parse(formula)
    #do naive solution first 
    #ex. line_coverage + branch_coverage / 2
    formula_items = []
    rest_of_formula = formula.clone
    while(! rest_of_formula.empty?)
      case rest_of_formula
        when /^\d/
          constant_value = rest_of_formula.slice! /^\d+/ 
          constant = Constant.find_by_value constant_value.to_d
          constant = Constant.create(:value => constant_value.to_d ) if constant.nil?
          formula_items << constant
        when /^\w/ 
          metric_or_operator = rest_of_formula.slice! /^\w+/ 
          if(metric_or_operator.size == 1)
            operator_name = metric_or_operator
            formula_items << find_operator(operator_name)
          else
            metric_key = metric_or_operator
            metric = Metric.find_by_key(metric_key)
            raise "#{metric_key} not a valid metric" if metric.nil?
            formula_items << metric
          end
        when /^\s/
          rest_of_formula.slice! /^\s+/ 
        else
          #must be an operator
          operator_name = rest_of_formula.slice! /^./ 
          formula_items << find_operator(operator_name)
      end
    end
    formula_items
  end


  private 

  def formula_is_valid
    unless @formula.nil?
      begin
        Formula.parse(@formula)
      rescue => e
        self.errors.add(:formula, e.message) 
      end
    end
  end
  
  def store_with_formula_items
      unsuccessful = []
      transaction do
        @is_in_transaction = true
        saved = []
        saved << save
        Formula.parse(formula).each do |item|
          saved << item.formula_items.create(:formula => self )
        end
        @is_in_transaction = false
        saved.each{|s|  unsuccessful << s if s == false }
        if(! unsuccessful.empty?)
          raise ActiveRecord::Rollback, "these were unsuccessfully saved: #{unsuccessful.to_yaml}"
        end
      end
      unsuccessful.size == 0
  end

  def self.find_operator(operator_name)
    operator = Operator.find_by_name(operator_name)
    raise "#{operator_name} is not a valid operator. Try using one of these: #{Operator.all.map(&:name).join(', ')}" if operator.nil?
    operator
  end
  
  def calculate(date)
    to_s   
  end

end
