module Jekyll

  class Site
    attr_accessor :morea_pages
  end

  class MoreaDirGenerator ## disable this plugin < Generator

    def generate(site)
      site.config['morea_pages'] = []
      puts "starting MoreaDirGenerator"
      morea_dir = site.config['morea'] || './_morea'
      all_raw_paths =
          Dir["#{morea_dir}/modules/*"] +
          Dir["#{morea_dir}/outcomes/*"] +
          Dir["#{morea_dir}/readings/*"] +
          Dir["#{morea_dir}/experiences/*"] +
          Dir["#{morea_dir}/assessments/*"]
      all_raw_paths.each do |f|
        if File.file?(File.join(site.source, '/', f))
          file_name = f.match(/[^\/]*$/)[0]
          file_path = f.gsub(/^#{morea_dir}\//, '')
          dir = extract_directory(file_path)
          site.config['morea_pages'] << MoreaPage.new(site,
                                         site.source, 
                                         dir,
                                         file_name,
                                         morea_dir,
                                         file_path)

        end
      end
    end

    def extract_directory(filepath)
      dir_match = filepath.match(/(.*\/)[^\/]*$/)
      if dir_match
        return dir_match[1]
      else
        return ''
      end
    end

  end


  class MoreaPage < Page

    attr_accessor :morea_type, :file_name, :file_path, :morea_dir

    def initialize(site, base, dir, file_name, morea_dir, file_path)
      @site = site
      @base = base
      @name = file_name
      @morea_type = dir.chomp('/')
      @file_name = file_name
      @file_path = file_path
      @morea_dir = morea_dir

      puts "Created MoreaPage #{morea_type} #{name}"
      # set @basename and @extname.
      process(file_name)

      read_yaml(File.join(base, morea_dir, dir), file_name)
    end


    # Provide additional properties for Liquid
    #
    # Returns <Hash>
    def to_liquid(attrs = ATTRIBUTES_FOR_LIQUID)
      super(attrs + %w[
      name
      morea_type
    ])
    end
  end
end
