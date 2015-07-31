module Jekyll
  module Commands
    class Post < Command
      def self.init_with_program(prog)
        prog.command(:post) do |c|
          c.syntax 'post NAME'
          c.description 'Creates a new post with the given NAME'

          options.each {|opt| c.option *opt }

          c.action { |args, options| process args, options }
        end
      end

      def self.options
        [
          ['extension', '-x EXTENSION', '--extension EXTENSION', 'Specify the file extension'],
          ['layout', '-l LAYOUT', '--layout LAYOUT', "Specify the post layout"],
          ['force', '-f', '--force', 'Overwrite a post if it already exists'],
          ['date', '-d DATE', '--date DATE', 'Specify the post date'],
          ['image', '-i IMAGE_PATH', '--image IMAGE_PATH', 'Specify the post image'],
          ['author', '-a AUTHOR', '--author AUTHON', 'Specify the post author'],
          ['categories', '-c CATEGORIES', '--categories CATEGORIES', 'Array of post categories'],
          ['tags', '-t TAGS', '--tags TAGS', 'Array of post tags']
        ]
      end

      def self.process(args = [], options = {})
        params = PostArgParser.new args, options
        params.validate!

        post = PostFileInfo.new params

        Compose::FileCreator.new(post, params.force?).create!
      end


      class PostArgParser < Compose::ArgParser
        def date
          options["date"].nil? ? Time.now : DateTime.parse(options["date"])
        end
      end

      class PostFileInfo < Compose::FileInfo
        def resource_type
          'post'
        end

        def path
          "_posts/#{file_name}"
        end

        def file_name
          "#{_date_stamp}-#{super}"
        end

        def _date_stamp
          @params.date.strftime '%Y-%m-%d'
        end
      end
    end
  end
end
