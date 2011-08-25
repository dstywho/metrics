module ReportDefinitionsHelper

  def cell_id(project,evaluation)
    "project_#{project.id}_evaluation_#{evaluation.id}"
  end
  
  def identify(*records)
    records.map{|r| "#{r.class.name.downcase}_#{r.id}"}.join('_')
  end


end
