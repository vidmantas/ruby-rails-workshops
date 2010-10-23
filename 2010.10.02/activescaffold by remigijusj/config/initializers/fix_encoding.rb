# encoding: utf-8

module ActionView
  module Renderable #:nodoc:
    private
      def compile!(render_symbol, local_assigns)
        locals_code = local_assigns.keys.map { |key| "#{key} = local_assigns[:#{key}];" }.join

        source = <<-end_src
          def #{render_symbol}(local_assigns)
            old_output_buffer = output_buffer;#{locals_code};#{compiled_source}
          ensure
            self.output_buffer = old_output_buffer
          end
        end_src
        source.force_encoding(Encoding::UTF_8) if source.respond_to?(:force_encoding)

        begin
          ActionView::Base::CompiledTemplates.module_eval(source, filename, 0)
        rescue Errno::ENOENT => e
          raise e # Missing template file, re-raise for Base to rescue
        rescue Exception => e # errors from template code
          if logger = defined?(ActionController) && Base.logger
            logger.debug "ERROR: compiling #{render_symbol} RAISED #{e}"
            logger.debug "Function body: #{source}"
            logger.debug "Backtrace: #{e.backtrace.join("\n")}"
          end

          raise ActionView::TemplateError.new(self, {}, e)
        end
      end
  end
end

module ActionController
  class Request
    private

      # Convert nested Hashs to HashWithIndifferentAccess and replace
      # file upload hashs with UploadedFile objects
      def normalize_parameters(value)
        case value
        when Hash
          if value.has_key?(:tempfile)
            upload = value[:tempfile]
            upload.extend(UploadedFile)
            upload.original_path = value[:filename]
            upload.content_type = value[:type]
            upload
          else
            h = {}
            value.each { |k, v| h[k] = normalize_parameters(v) }
            h.with_indifferent_access
          end
        when Array
          value.map { |e| normalize_parameters(e) }
        else
          value.force_encoding(Encoding::UTF_8) if value.respond_to?(:force_encoding)
          value
        end
      end
  end
end
