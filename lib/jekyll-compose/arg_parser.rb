class Jekyll::Compose::ArgParser
  attr_reader :args, :options
  def initialize(args, options)
    @args = args
    @options = options
  end

  def validate!
    raise ArgumentError.new('You must specify a name.') if args.empty?
  end

  def type
    type = options["extension"] || Jekyll::Compose::DEFAULT_TYPE
  end

  def layout
    layout = options["layout"] || Jekyll::Compose::DEFAULT_LAYOUT
  end

  def author
    author = options["author"] || Jekyll::Compose::DEFAULT_AUTHOR
  end

  def image
    image = options["image"] || Jekyll::Compose::DEFAULT_IMAGE
  end

  def categories
    categories = options["categories"] || Jekyll::Compose::DEFAULT_CATEGORIES
  end

  def tags
    tags = options["tags"] || Jekyll::Compose::DEFAULT_TAGS
  end

  def date
    date = options["date"] || Time.now.strftime('%Y-%m-%d %H:%M:%S')
  end

  def title
    args.join ' '
  end

  def force?
    !!options["force"]
  end
end
