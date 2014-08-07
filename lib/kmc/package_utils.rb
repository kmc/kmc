module Kmc
  module PackageUtils
    # Lowercases and hyphenates a package name; this is the format packages
    # are expected to be supplied as when passed from the user.
    def normalize_for_find(name)
      name.downcase.strip.gsub(/[ \-]+/, '-').gsub(/[^\w-]/, '')
    end

    def normalized_title
      normalize_for_find(title)
    end

    def find(name)
      packages.find do |package|
        package.names.any? do |candidate_name|
          normalize_for_find(candidate_name) == normalize_for_find(name)
        end
      end
    end

    def search(name)
      packages.min_by do |package|
        package.names.map do |candidate_name|
          DamerauLevenshtein.distance(name, candidate_name)
        end.min
      end
    end
  end
end
