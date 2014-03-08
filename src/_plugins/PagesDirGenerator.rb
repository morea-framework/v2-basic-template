module Jekyll

  class PagesDirGenerator < Generator

    def generate(site)
      puts "Starting Morea page processing..."
      site.config['morea_module_pages'] = []
      site.config['morea_outcome_pages'] = []
      site.config['morea_reading_pages'] = []
      site.config['morea_experience_pages'] = []
      site.config['morea_assessment_pages'] = []
      site.config['morea_page_table'] = {}
      pages_dir = site.config['pages'] || './_morea'
      all_raw_paths = Dir["#{pages_dir}/**/*"]
      all_raw_paths.each do |f|

        if File.file?(File.join(site.source, '/', f))
          filename = f.match(/[^\/]*$/)[0]
          clean_filepath = f.gsub(/^#{pages_dir}\//, '')
          clean_dir = extract_directory(clean_filepath)

          new_page = PagesDirPage.new(site,
                                      site.source,
                                      clean_dir,
                                      filename,
                                      pages_dir)
          # Ruby Newbie Alert. There is definitely a one liner to do the following:
          if new_page.published?
            site.pages << new_page
            site.config['morea_page_table'][new_page.data['morea_id']] = new_page
            if new_page.data['morea_type'] == 'module'
              site.config['morea_module_pages'] << new_page
            else
              if new_page.data['morea_type'] == 'outcome'
                site.config['morea_outcome_pages'] << new_page
              else
                if new_page.data['morea_type'] == "reading"
                  site.config['morea_reading_pages'] << new_page
                else
                  if new_page.data['morea_type'] == "experience"
                    site.config['morea_experience_pages'] << new_page
                  else
                    if new_page.data['morea_type'] == "assessment"
                      site.config['morea_assessment_pages'] << new_page
                    end
                  end
                end
              end
            end
          end

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


  class PagesDirPage < Page

    def initialize(site, base, dir, name, pagesdir)

      read_yaml(File.join(base, pagesdir, dir), name)

      @site = site # site instance
      @base = base  # src dir
      @dir = "_morea_dir/" + self.data['morea_type'] + 's'
      @name = name # the file name

      process(name)
      puts "Processing page: #{@name}"
      puts "   data: #{@data}"
    end

    # Whether the file is published or not, as indicated in YAML front-matter
    # Ruby Newbie Alert: copied this from Convertible cause 'include Convertible' didn't work for me.
    def published?
      !(data.has_key?('published') && data['published'] == false)
    end

  end


end

