module Jekyll

  class Site
    attr_accessor :morea
  end

  class MoreaDirGenerator < Generator

    def generate(site)
      site.morea = []
      puts "starting MoreaDirGenerator"
      morea_dir = site.config['morea'] || './_morea'
      all_raw_paths =
          Dir["#{morea_dir}/modules/*"] +
          Dir["#{morea_dir}/outcomes/*"] +
          Dir["#{morea_dir}/readings/*"] +
          Dir["#{morea_dir}/experiences/*"] +
          Dir["#{morea_dir}/assessments/*"]
      all_raw_paths.each do |f|
        puts "Processing file: " + f

        if File.file?(File.join(site.source, '/', f))
          filename = f.match(/[^\/]*$/)[0]
          clean_filepath = f.gsub(/^#{morea_dir}\//, '')
          clean_dir = extract_directory(clean_filepath)
          puts "Clean dir = " + clean_dir
          puts "Clean_filepath = " + clean_filepath
          puts "filename = " + filename

          site.morea << MoreaDirPage.new(site,
                                         site.source, 
                                         clean_dir, 
                                         filename, 
                                         morea_dir)

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


  class MoreaDirPage < Page

    def initialize(site, base, dir, name, pagesdir)
      @site = site
      @base = base
      @dir = dir
      @name = name

      process(name)

      read_yaml(File.join(base, pagesdir, dir), name)
    end
  end
end
