namespace :app do
  
  desc "setup a new db, dropping the old one if it exists and seed the new one"
  task :reset => ["db:drop", "db:create", "db:migrate", "db:seed", 'app:populate']
  
  desc "populate the db and/or update it"
  task :populate => :environment do
    
    reports = []
    [
      {:name => "Team 1's projects for June 2011", :date => Date.parse("2011-06-30")},
      {:name => "Team 2's projects for May 2011", :date => Date.parse("2011-05-31")},
      {:name => "Company's projects for 2010", :date => Date.parse("2010-12-31")}
    ].each do |attributes|
      reports << Report.find_or_create_by_name(attributes)
    end



#FORMULA STUFF
      coverage = Formula.find_or_create_by_name(:name => 'coverage')
      single_resp = Formula.find_or_create_by_name(:name => 'single responsibility')
      class_size = Formula.find_or_create_by_name(:name => 'class size')
      
      formulas = [coverage, single_resp, class_size]
      f = coverage;
      FormulaItem.create(:item => Operator.find_by_name('('), :formula => f)
      FormulaItem.create(:item => Metric.find_by_key('branch_coverage'), :formula => f)
      FormulaItem.create(:item => Operator.find_by_name('+'), :formula => f)
      FormulaItem.create(:item => Metric.find_by_key('line_coverage'), :formula => f)
      FormulaItem.create(:item => Operator.find_by_name(')'), :formula => f)
      FormulaItem.create(:item => Operator.find_by_name('/'), :formula => f)

      f = single_resp 
      FormulaItem.create(:item => Metric.find_by_key('lcom4'), :formula => f)
      FormulaItem.create(:item => Operator.find_by_name('*'), :formula => f)
      FormulaItem.create(:item => Constant.find_or_create_by_value('4'), :formula => f)

      f = class_size
      FormulaItem.create(:item => Metric.find_by_key('ncloc'), :formula => f)
      FormulaItem.create(:item => Operator.find_by_name('/'), :formula => f)
      FormulaItem.create(:item => Metric.find_by_key('classes'), :formula => f)
    
    number_of_projects = Project.count
    reports.each do |report|

      #formula_reports
      formulas.each do |formula|
        report.formula_reports.create(:formula_id => formula.id)
      end
      
      #project_reports
      (rand(6) + 1).times do |i|
        new_project = Project.find(rand(number_of_projects + 1))
        report.project_reports.create(:project_id => new_project.id) unless report.projects.include? new_project
      end
      
    end
    
    
      

  end
  
  
end
