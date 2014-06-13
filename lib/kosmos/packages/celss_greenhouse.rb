class CELSSGreenhouse < Kosmos::Package
  title 'CELSS Greenhouse'
  url 'https://github.com/cerebrate/celss-greenhouse/releases/download/0.3-beta/LacunaGreenhouse-0.3.zip'

  def install
    merge_directory 'GameData'
  end
end

