class DatepickerInput < SimpleForm::Inputs::Base
  def input
    template.content_tag :div, class: 'simpleform-inline-datepicker' do
      @builder.hidden_field(attribute_name, :class => 'datepicker-input')
    end
  end

  def input_options
    super.tap do |options|
      options[:include_blank] = true
      options[:order]         = [:day, :month, :year]
      options[:start_year]    = Time.now.year - 100
      options[:end_year]      = Time.now.year - 18
    end
  end
end
