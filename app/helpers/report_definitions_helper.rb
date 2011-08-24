module ReportDefinitionsHelper
  def cell_id(project,evaluation)
    "project_#{project.id}_evaluation_#{evaluation.id}"
  end
end
