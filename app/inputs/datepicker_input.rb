class DatepickerInput < SimpleForm::Inputs::Base
  def input
    template.content_tag :div, class: 'simpleform-inline-datepicker' do
      attr = @builder.object.send(attribute_name)
      value = attr.respond_to?(:strftime) ? attr.strftime("%Y/%m/%d") : attr.to_s

      @builder.hidden_field(attribute_name, value: value, class: 'datepicker-input')
    end
  end

  def input_options
    super.tap do |options|
      options[:include_blank] = true
      options[:order]         = [:year, :month, :day]
      options[:start_year]    = Time.now.year - 100
      options[:end_year]      = Time.now.year - 18
    end
  end
end
