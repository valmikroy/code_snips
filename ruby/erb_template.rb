#!/usr/bin/env ruby


require 'erb'

module Helper
  class Template
    include ERB::Util
    attr_accessor :data, :template
    def initialize(data, template)
      @data = data
      @template = template
    end

    def render
      ERB.new(@template, nil, '-').result(binding)
    end

    def save(file)
      File.open(file, 'w+') { |f| f.write(render) }
    end
  end

        def render_tmpl(tmpl, data)
                e = Template.new(data, tmpl)
                e.render
        end

end

include Helper


ERB_STR = %{
        one   for <%=@data[:one]%>
        two   for <%=@data[:two]%>
  three for <%=@data[:three]%>
}


ERB_LOOP = %{
<% @data.each do |k, v| %>
  key <%= k %> and value <%= v.chomp %>
<% end %>
}



data = {
  :one => '11111111',
  :two => '22222222',
  :three => '3333333',
}

puts render_tmpl(ERB_STR,data)
puts render_tmpl(ERB_LOOP,data)
