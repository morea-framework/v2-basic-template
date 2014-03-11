# Processes pages in the _morea directory.
# Adapted from: https://github.com/bbakersmith/jekyll-pages-directory

module Jekyll

  class MoreaGenerator < Generator

    attr_accessor :summary

    def configSite(site)
      site.config['morea_module_pages'] = []
      site.config['morea_outcome_pages'] = []
      site.config['morea_reading_pages'] = []
      site.config['morea_experience_pages'] = []
      site.config['morea_assessment_pages'] = []
      site.config['morea_page_table'] = {}
    end

    def generate(site)
      puts "\nStarting Morea page processing..."
      configSite(site)
      @summary = MoreaGeneratorSummary.new(site)
      morea_dir = site.config['morea_dir'] || './_morea'
      morea_file_paths = Dir["#{morea_dir}/**/*"]
      morea_file_paths.each do |f|

        if File.file?(File.join(site.source, '/', f))
          file_name = f.match(/[^\/]*$/)[0]
          relative_file_path = f.gsub(/^#{morea_dir}\//, '')
          subdir = extract_directory(relative_file_path)

          @summary.total_files += 1
          if File.extname(file_name) == '.md'
            puts "  Processing Morea file:     #{file_name}"
            @summary.morea_files += 1
            processMoreaFile(site, subdir, file_name, morea_dir)
          else
            puts "  Processing non-Morea file: #{file_name}"
            @summary.non_morea_files += 1
            processNonMoreaFile(site, subdir, file_name, morea_dir)
          end
        end
      end
      check_for_undeclared_morea_id_references(site)
      site.config['morea_page_table'].each do |morea_id, morea_page|
        morea_page.print_problems_if_any
      end

      puts @summary
    end

    def check_for_undeclared_morea_id_references(site)
      site.config['morea_page_table'].each do |morea_id, morea_page|
        # Check for required tags for module pages.
        if (morea_page.data['morea_type'] == 'module')
          if morea_page.data['morea_outcomes']
            morea_page.data['morea_outcomes'].each do |morea_id_reference|
              unless site.config['morea_page_table'][morea_id_reference]
                morea_page.undefined_id << morea_id_reference
                @summary.yaml_errors += 1
              end
            end
          end
        end
      end
    end

    # Copy all non-markdown files to destination directory unchanged.
    # Jekyll will create a _morea directory in the destination that holds these files.
    def processNonMoreaFile(site, relative_dir, file_name, morea_dir)
      source_dir = morea_dir + "/" + relative_dir
      site.static_files << Jekyll::StaticFile.new(site, site.source, source_dir, file_name)
    end

    def processMoreaFile(site, subdir, file_name, morea_dir)
      new_page = MoreaPage.new(site, subdir, file_name, morea_dir)
      validate(new_page, site)
      # Ruby Newbie Alert. There is definitely a one liner to do the following:
      # Note that even pages with errors are going to try to be published.
      if new_page.published?
        @summary.published_files += 1
        site.pages << new_page
        site.config['morea_page_table'][new_page.data['morea_id']] = new_page
        if new_page.data['morea_type'] == 'module'
          site.config['morea_module_pages'] << new_page
          module_page = ModulePage.new(site, site.source, new_page.data['morea_id'], new_page)
          site.pages << module_page
        elsif new_page.data['morea_type'] == 'outcome'
          site.config['morea_outcome_pages'] << new_page
        elsif new_page.data['morea_type'] == "reading"
          site.config['morea_reading_pages'] << new_page
        elsif new_page.data['morea_type'] == "experience"
          site.config['morea_experience_pages'] << new_page
        elsif new_page.data['morea_type'] == "assessment"
          site.config['morea_assessment_pages'] << new_page
        end
      else
        @summary.unpublished_files += 1
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

    def validate(morea_page, site)
      # Check for required tags: morea_id, morea_type, and title.
      if !morea_page.data['morea_id']
        morea_page.missing_required << "morea_id"
        @summary.yaml_errors += 1
      end
      if !morea_page.data['morea_type']
        morea_page.errors << "morea_type"
        @summary.yaml_errors += 1
      end
      if !morea_page.data['title']
        morea_page.errors << "title"
        @summary.yaml_errors += 1
      end

      # Check for required tags for experience and reading pages.
      if (morea_page.data['morea_type'] == 'experience') || (morea_page.data['morea_type'] == 'reading')
          if !morea_page.data['morea_summary']
          morea_page.errors << "morea_summary"
          @summary.yaml_errors += 1
        end
        if !morea_page.data['morea_url']
          morea_page.errors << "morea_url"
          @summary.yaml_errors += 1
        end
      end

      # Check for required tags for module pages.
      if (morea_page.data['morea_type'] == 'module')
        if !morea_page.data['morea_outcomes']
          morea_page.errors << "morea_outcomes"
          @summary.yaml_errors += 1
        end
        if !morea_page.data['morea_readings']
          morea_page.errors << "morea_readings"
          @summary.yaml_errors += 1
        end
        if !morea_page.data['morea_experiences']
          morea_page.errors << "morea_experiences"
          @summary.yaml_errors += 1
        end
        if !morea_page.data['morea_assessments']
          morea_page.errors << "morea_assessments"
          @summary.yaml_errors += 1
        end
        if !morea_page.data['morea_icon_url']
          morea_page.errors << "morea_icon_url"
          @summary.yaml_errors += 1
        end
      end

      # Check for optional tags
      if !morea_page.data['published']
        morea_page.missing_optional << "published (set to true)"
        morea_page.data['published'] = true
        @summary.yaml_warnings += 1
      end
      if !morea_page.data['morea_sort_order']
        morea_page.warnings << "morea_sort_order (set to 0)"
        morea_page.data['morea_sort_order'] = 0
        @summary.yaml_warnings += 1
      end

      # Check for duplicate id
      if morea_page.data['morea_id'] && site.config['morea_page_table'].has_key?(morea_page.data['morea_id'])
        morea_page.duplicate_id = true
        @summary.yaml_errors += 1
      end
    end
  end


  # Every markdown file in the _morea directory becomes a MoreaPage.
  class MoreaPage < Page
    attr_accessor :missing_required, :missing_optional, :duplicate_id, :undefined_id

    def initialize(site, subdir, file_name, morea_dir)
      read_yaml(File.join(site.source, morea_dir, subdir), file_name)
      @site = site
      @base = site.source
      @dir = subdir
      @name = file_name
      @missing_required = []
      @missing_optional = []
      @undefined_id = []
      @duplicate_id = false
      process(file_name)
    end

    # Whether the file is published or not, as indicated in YAML front-matter
    # Ruby Newbie Alert: copied this from Convertible cause 'include Convertible' didn't work for me.
    def published?
      !(data.has_key?('published') && data['published'] == false)
    end

    # True if any validation problems or undefined id references on this page.
    def problems?
      (@missing_required.size + @missing_optional.size + @undefined_id.size > 0) || @duplicate_id
    end

    # Prints a string listing warnings or errors if there were any, otherwise does nothing.
    def print_problems_if_any
      if self.problems?
        puts "  Issue discovered in #{@name}:"
      end
      if @missing_required.size > 0
        puts "    Missing required front matter: " + @missing_required*","
      end
      if @missing_optional.size > 0
        puts "    Missing optional front matter: " + @missing_optional*","
      end
      if @duplicate_id
        puts "    Duplicate id: #{@data['morea_id']}"
      end
      if @undefined_id.size > 0
        puts "    Reference to undefined morea_id in yaml: " + @undefined_id*","
      end
    end
  end

  # Module pages are dynamically generated, one per MoreaPage with morea_type = module.
  class ModulePage < Page
    def initialize(site, base, dir, morea_page)
      @site = site
      @base = base
      @dir = "modules/" + dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'module.html')
      self.data['morea_page'] = morea_page
      self.data['title'] = morea_page.data['title']
    end
  end

  # Tallies the files processed in order to provide a summary at end of generator stage.
  class MoreaGeneratorSummary
    attr_accessor :total_files, :published_files, :unpublished_files, :morea_files, :non_morea_files, :yaml_warnings, :yaml_errors

    def initialize(site)
      @site = site
      @total_files = 0
      @published_files = 0
      @unpublished_files = 0
      @morea_files = 0
      @non_morea_files = 0
      @yaml_warnings = 0
      @yaml_errors = 0
    end

    def to_s
      "  Summary:\n    #{@total_files} total, #{@published_files} published, #{@unpublished_files} unpublished, #{@morea_files} morea, #{@non_morea_files} non-morea\n    #{@site.config['morea_module_pages'].size} modules, #{@site.config['morea_outcome_pages'].size} outcomes, #{@site.config['morea_reading_pages'].size} readings, #{@site.config['morea_experience_pages'].size} experiences, #{@site.config['morea_assessment_pages'].size} assessments\n    #{@yaml_errors} errors, #{@yaml_warnings} warnings"
    end
  end


end

