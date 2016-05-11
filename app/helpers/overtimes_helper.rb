module OvertimesHelper
  def get_project_name(id)
    return Project.find(id).name rescue "项目不存在"
  end
end
