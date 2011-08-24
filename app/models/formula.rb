class Formula < ActiveRecord::Base

  attr_accessor :formula 

  has_many :formula_items, :dependent => :delete_all
  validate :formula_is_valid

  def create_or_update
    if @formula.nil? || @is_in_transaction
      super
    else
      formula_items.delete_all unless new_record? 
      store_with_formula_items
    end
  end

  def self.parse(formula)
    #do naive solution first 
    #ex. line_coverage + branch_coverage / 2
    formula_items = []
    rest_of_formula = formula.clone
    operators = Operator.all.map(&:name)
    isOperator = Regexp.new("^(#{Operator.all.map(&:escaped).join('|')}){1}")
    while(! rest_of_formula.empty?)
      case rest_of_formula
        when isOperator
          operator_name = rest_of_formula.slice! isOperator
          formula_items << find_operator(operator_name)
        when /^\d/ #constant
          constant_value = rest_of_formula.slice! /^(\d|\.)+/ 
          constant = Constant.find_by_value constant_value.to_d
          constant = Constant.create(:value => constant_value.to_d ) if constant.nil?
          formula_items << constant
        when /^\w/ #metric
          metric_key = rest_of_formula.slice! /^\w+/ 
          metric = Metric.find_by_key(metric_key)
          raise "#{metric_key} not a valid metric" if metric.nil?
          formula_items << metric
        when /^\s/
          rest_of_formula.slice! /^\s+/ 
        else
          raise "unable to parse the rest of this: '#{rest_of_formula}'"
      end
    end
    formula_items
  end

  #ajax if possible
  #possibly SLOW calls Project sync_snapshots
  def calculate(project, datetime)
    begin 
      eval(evaluated_string(project,datetime))
    rescue Exception => e
      e.message  
    end
  end

  #ajax if possible
  #possibly SLOW calls Project sync_snapshots
  def evaluated_string(project,datetime)
    to_be_evaled = to_s
    snapshots = project.snapshots(formula_items.metrics.map{|m| m.item },datetime)
    snapshots.each do |snapshot|
      to_be_evaled.gsub!(snapshot.metric.key, snapshot.value.to_s) unless snapshot.nil?
    end
    to_be_evaled
  end

  def to_s
    display = ""
    formula_items.each_with_index do |item, index|
      display << " " unless index == 0
      if(item.metric? )
        display << item.item.key
      else
        display << item.item.name.to_s
      end
    end
    display
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
    raise "'#{operator_name}' is not a valid operator. Try using one of these: #{Operator.all.map(&:name).join(', ')}" if operator.nil?
    operator
  end

  


end
