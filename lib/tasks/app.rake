namespace :app do
  
  desc "setup a new db, dropping the old one if it exists and seed the new one"
  task :reset => ["db:drop", "db:create", "db:migrate", "db:seed"]
  
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

    formulas = [
    Formula.find_or_create_by_name(:name => 'coverage', :formula => "(branch_coverage + line_coverage)/2"),
    Formula.find_or_create_by_name(:name => 'single responsibility', :formula => "lcom4 * 4"),
    Formula.find_or_create_by_name(:name => 'class size', :formula => "ncloc / classes")
    ]
    
    number_of_projects = Project.count
    
    reports.each do |report|
      formulas.each do |formula|
        report.formula_reports.create(:formula_id => formula.id)
      end
      
      (rand(6) + 1).times do |i|
        new_project = Project.find(rand(number_of_projects + 1))
        report.project_reports.create(:project_id => new_project.id) unless report.projects.include? new_project
      end
    end
    
    
      

  end
  
  
end