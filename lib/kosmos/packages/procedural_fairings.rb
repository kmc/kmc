class ProceduralFairings < Kosmos::Package
  title 'Procedural Fairings'
  url 'https://github.com/e-dog/ProceduralFairings/releases/download/v3.02/ProcFairings_3.02.zip'

  def install
    merge_directory 'GameData'
  end
end
