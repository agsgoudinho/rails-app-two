module ApplicationHelper
  def link_to_remove_fields(name, form)
    form.hidden_field(:_destroy) +
        link_to(name, "javascript:void(0)", onclick: "remove_fields(this)")
  end

  def link_to_add_fields(name, form, association)
    new_object = form.object.class.reflect_on_association(association).klass.new
    fields = form.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :form => builder)
    end
    link_to(name, "javascript:void(0)", onclick: h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end
end
