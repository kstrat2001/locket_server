module ApplicationHelper
  def is_site?
    controller.class.name.split("::").first=="Site" 
  end
end
