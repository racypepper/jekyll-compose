class Jekyll::Compose::FileInfo
  attr_reader :params
  def initialize(params)
    @params = params
  end

  def file_name
    name = Jekyll::Utils.slugify params.title
    "#{name}.#{params.type}"
  end

  def content
    <<-CONTENT.gsub /^\s+/, ''
      ---
      layout: #{params.layout}
      title:  #{params.title}
      image:  #{params.image}
      author: #{params.author}
      date:   #{params.date}
      categories: #{params.categories}  
      tags:   #{params.tags}
      ---
    CONTENT
  end
end
