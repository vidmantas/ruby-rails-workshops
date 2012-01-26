module ActionView
  module Helpers
    class InstanceTag
      def to_label_tag(text = nil, options = {})
        options = options.stringify_keys
        name_and_id = options.dup
        add_default_name_and_id(name_and_id)
        options.delete("index")
        options.delete("locale")
        options["for"] ||= name_and_id["id"]
        content = (text.blank? ? nil : text.to_s) || method_name.humanize
        label_tag(name_and_id["id"], content, options)
      end
      
      def to_input_field_tag(field_type, options = {})
        options = options.stringify_keys
        options["size"] = options["maxlength"] || DEFAULT_FIELD_OPTIONS["size"] unless options.key?("size")
        options = DEFAULT_FIELD_OPTIONS.merge(options)
        if field_type == "hidden"
          options.delete("size")
        end
        options["type"] = field_type
        options["value"] ||= (options["locale"] ?
          object.send(sanitized_method_name, options['locale']) :
          value_before_type_cast(object)) unless field_type == "file"
        options["value"] &&= html_escape(options["value"])
        add_default_name_and_id(options)
        tag("input", options)
      end
      
      def to_text_area_tag(options = {})
        options = DEFAULT_TEXT_AREA_OPTIONS.merge(options.stringify_keys)
        value = options.delete('value') || (options["locale"] ?
          object.send(sanitized_method_name, options['locale']) :
          value_before_type_cast(object))
        add_default_name_and_id(options)

        if size = options.delete("size")
          options["cols"], options["rows"] = size.split("x") if size.respond_to?(:split)
        end

        content_tag("textarea", html_escape(value), options)
      end
      
      private
        def add_default_name_and_id(options)
          if options.has_key?("index")
            options["name"] ||= tag_name_with_index(options["index"])
            options["id"] ||= tag_id_with_index(options["index"])
            options.delete("index")
          elsif defined?(@auto_index)
            options["name"] ||= tag_name_with_index(@auto_index)
            options["id"] ||= tag_id_with_index(@auto_index)
          elsif options.has_key?("locale")
            options["name"] ||= tag_name_with_locale(options["locale"])
            options["id"] ||= tag_id_with_locale(options["locale"])
            options["lang"] ||= options.delete("locale")
          else
            options["name"] ||= tag_name + (options.has_key?('multiple') ? '[]' : '')
            options["id"] ||= tag_id
          end
        end

        def tag_name_with_locale(locale)
          "#{@object_name}[#{sanitized_method_name}][#{locale}]"
        end

        def tag_id_with_locale(locale)
          "#{sanitized_object_name}_#{sanitized_method_name}_#{locale}"
        end
    end
  end
end