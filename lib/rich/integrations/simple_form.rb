class RichInput < SimpleForm::Inputs::TextInput
  def input
    scope_type = object_name
    scope_id = object.id
    editor_options = Rich.options(options[:config])
    raise "#{scope_type} - #{scope_id} - #{editor_options}"
    super << javascript_tag(editor_options).html_safe
  end

  protected

  def javascript_tag options
    <<-JAVASCRIPT
      <script>
        $(function() {
          $('##{dom_id}').ckeditor(function() { }, #{options.to_json} );
        });
      </script>
    JAVASCRIPT
  end
end
