module ReportDefinitionsHelper

  def cell_id(project,evaluation)
    "project_#{project.id}_evaluation_#{evaluation.id}"
  end
  
  def identify(*records)
    records.map{|r| "#{r.class.name.downcase}_#{r.id}"}.join('_')
  end

  def date_format(time)
    time.strftime '%B %e, %Y' 
  end

  def formula_graph_id(formula)
    "formula_graph_#{formula.id}"
  end


end
