module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  # From Nested Forms Railscast http://railscasts.com/episodes/197-nested-model-form-part-2
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to(name, '#', onclick: "remove_fields(this)")
  end
  
  # Adds partial for xxx_fields as child of xxx_fields
  def link_to_add_fields(name, f, association, id)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to(name, '#', onclick: "add_fields('#{id}', '#{association}', '#{escape_javascript(fields)}')")
  end

  def bootstrap_type(type)
    case type
      when :alert
        "alert-warning"
      when :error
        "alert-danger"
      when :notice
        "alert-info"
      when :success
        "alert-success"
      else
        type.to_s
    end
  end

end
