class Formula < ActiveRecord::Base

  attr_accessor :formula
  has_many :formula_items


  def self.parse(formula)
    #do naive solution first 
    #ex. line_coverage + branch_coverage / 2
    formula_items = []
    rest_of_formula = formula.clone
    while(! rest_of_formula.empty?)
      case rest_of_formula
        when /^\w/ 
          metric_or_operator = rest_of_formula.slice! /^\w+/ 
          if(metric_or_operator.size == 1)
            operator_name = metric_or_operator
            debugger
            formula_items << find_operator(operator_name)
          else
            metric_name = metric_or_operator
            metric = Metric.find_by_name(metric_name)
            raise "metric is invalid,  #{metric_name} not found" if metric.nil?
            debugger
            formula_items << metric
          end
        when /^\d/
          constant_value = rest_of_formula.slice! /^\d+/ 
          constant = Constant.find_by_value constant_value.to_d
          Constant.create(:value => constant_value.to_d ) if constant.nil?
          formula_items << constant
        when /^\s/
          rest_of_formula.slice! /^\s+/ 
        else
          #must be an operator
          operator_name = rest_of_formula.slice! /^./ 
          debugger
          formula_items << find_operator(operator_name)
      end
    end
    formula_items
  end


  private 

  def self.find_operator(operator_name)
    operator = Operator.find_by_name(operator_name)
    raise "operator is invalid, #{operator_name} is not found" if operator_name.nil?
    operator
  end
  
  
  def calculate(date)
    to_s   
  end

end
