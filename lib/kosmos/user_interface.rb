class String
  def undent
    gsub(/^.{#{slice(/^ +/).length}}/, '')
  end
end

module Kosmos
  module UserInterface
    class << self
      def init(args)
        ksp_path = extract_ksp_path_from_args(args)

        unless ksp_path
          Util.log <<-EOS.undent
            Error: You did not specify what folder you keep KSP in.

            Before doing anything else, please execute the command:

              kosmos init ksp-folder

            Where "ksp-folder" is the name of the folder where you keep KSP.
          EOS

          return
        end

        Util.log "Initializing Kosmos into #{ksp_path} (This will take a sec) ..."

        Kosmos::Versioner.init_repo(ksp_path)
        Kosmos.save_ksp_path(ksp_path)

        Util.log <<-EOS.undent
          Done! You're ready to begin installing mods.

          Install your first mod by running the command:

              kosmos install [name-of-the-mod]
        EOS
      end

      def install(args)
        return unless check_initialized!

        ksp_path = Kosmos.load_ksp_path

        packages = load_packages(args)
        return unless packages

        return unless check_installed_packages(ksp_path, packages)

        Util.log "Kosmos is about to install #{packages.count} package(s):"
        pretty_print_list(packages.map(&:title))

        packages.each do |package|
          Util.log "Installing package #{package.title} ..."
          package.new.install!(ksp_path)
          Util.log "Done!"
        end
      end

      def uninstall(args)
        return unless check_initialized!

        ksp_path = Kosmos.load_ksp_path

        package_name = args.shift
        unless package_name
          Util.log <<-EOS.undent
            Error: You need to specify what package to uninstall. Example:
                kosmos uninstall name-of-the-mod"
          EOS

          return
        end

        package = Kosmos::Package.find(package_name)
        installed_packages = Kosmos::Versioner.installed_packages(ksp_path)

        if !package
          Util.log "Error: Kosmos couldn't find any packages with the name #{package_name.inspect}."
        elsif !installed_packages.include?(package.title)
          Util.log <<-EOS.undent
            Error: #{package.title} is not currently installed.

            There are three reasons you may get this error:

              1. You have already uninstalled #{package.title}.
              2. You have never previously installed #{package.title}.
              3. You did not use Kosmos to install #{package.title}.
          EOS
        else
          Util.log "Preparing to uninstall #{package.title} ..."
          Kosmos::Versioner.uninstall_package(ksp_path, package)
          Util.log "Done! Just uninstalled: #{package.title}."
        end
      end

      def list(args)
        return unless check_initialized!

        ksp_path = Kosmos.load_ksp_path

        packages = Kosmos::Versioner.installed_packages(ksp_path)
        Util.log "You have installed #{packages.length} mod(s) using Kosmos:"
        pretty_print_list(packages)
      end

      def server(args)
        Web::App.start!
      end

      private

      # Extracts the path to init to from the user-supplied arguments. If the
      # user passed arguments via the commandline, then spaces in paths are
      # auto-handled beacuse they come from ARGV.
      #
      # If, however, the user passed arguments from the server, then these
      # arguments will still be separated by spaces. This method will then re-
      # join them.
      def extract_ksp_path_from_args(args)
        if args
          path = args.join(' ')

          # Trim leading quotation mark if any
          path = path[1..-1] if path.start_with?('"')
          path = path[0..-2] if path.end_with?('"')

          if path.empty?
            nil
          else
            path
          end
        end
      end

      def check_initialized!
        if Kosmos.load_ksp_path
          true
        else
          Util.log <<-EOS.undent
            Error: You have not yet initialized Kosmos.

            Before doing anything else, please execute the command:

              kosmos init ksp-folder

            Where "ksp-folder" is the name of the folder where you keep KSP.
          EOS
        end
      end

      def pretty_print_list(list)
        list.each { |value| Util.log "  * #{value}" }
      end

      def load_packages(package_names)
        packages = Hash[package_names.map do |name|
          [name, Kosmos::Package.find(name)]
        end]

        unknown_packages = packages.select { |_, package| package.nil? }
        package_suggestions = unknown_packages.map do |name, _|
          best_guess = Kosmos::Package.search(name).normalized_title
          "#{name} (Maybe you meant: #{best_guess.inspect}?)"
        end

        if unknown_packages.any?
          Util.log "Error: Kosmos couldn't find any packages with the following names:"
          pretty_print_list(package_suggestions)

          return false
        end

        packages.values
      end

      def check_installed_packages(ksp_path, packages)
        installed_titles = Kosmos::Versioner.installed_packages(ksp_path)

        installed_packages = packages.select do |package|
          installed_titles.include?(package.title)
        end

        if installed_packages.any?
          Util.log "Error: You have already installed the following packages using Kosmos:"
          pretty_print_list(installed_packages.map(&:title))
        end

        installed_packages.empty?
      end
    end
  end
end
