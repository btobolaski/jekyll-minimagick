require 'mini_magick'

module Jekyll
  module JekyllRetinamagick

    class GeneratedImageFile < Jekyll::StaticFile
      # Initialize a new GeneratedImage.
      #   +site+ is the Site
      #   +base+ is the String path to the <source>
      #   +dir+ is the String path between <source> and the file
      #   +name+ is the String filename of the file
      #   +preset+ is the Preset hash from the config.
      #
      # Returns <GeneratedImageFile>
      def initialize(site, base, dir, name, preset, retina)
        @site = site
        @base = base
        @dir  = dir
        @name = name
        @dst_dir = preset.delete('destination')
        @src_dir = preset.delete('source')
        @commands = preset
        @retina = retina
      end

      # Obtains source file path by substituting the preset's source directory
      # for the destination directory.
      #
      # Returns source file path.
      def path
        File.join(@base, @dir.sub(@dst_dir, @src_dir), @name)
      end

      # Use MiniMagick to create a derivative image at the destination
      # specified (if the original is modified).
      #   +dest+ is the String path to the destination dir
      #
      # Returns false if the file was not modified since last time (no-op).
      def write(dest)
        dest_path = destination(dest)
        if @retina
          filepath, extension = dest_path.match(/(.+)(\.[a-zA-Z]{3,4})/i).captures
          dest_path = "#{filepath}@2x#{extension}"
        end

        return false if File.exist? dest_path

        @@mtimes[path] = mtime

        FileUtils.mkdir_p(File.dirname(dest_path))
        image = ::MiniMagick::Image.open(path)
        @commands.each_pair do |command, arg|
          if @retina
            width, height = arg.match(/([0-9]+)x([0-9]+)/i).captures
            arg = "#{Integer(width) * 2}x#{Integer(height) * 2}"
          end
          image.resize arg
        end
        image.write dest_path

        true
      end

    end

    class MiniMagickGenerator < Generator
      safe true

      # Find all image files in the source directories of the presets specified
      # in the site config.  Add a GeneratedImageFile to the static_files stack
      # for later processing.
      def generate(site)
        return unless site.config['retinamagick']

        site.config['retinamagick'].each_pair do |name, preset|
          Dir.glob(File.join(site.source, preset['source'], "*.{png,jpg,jpeg,gif}")) do |source|
            site.static_files << GeneratedImageFile.new(site, site.source, preset['destination'], File.basename(source), preset.clone, false)
            site.static_files << GeneratedImageFile.new(site, site.source, preset['destination'], File.basename(source), preset.clone, true)
          end
        end
      end
    end

  end
end
