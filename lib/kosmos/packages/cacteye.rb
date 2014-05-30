class Cacteye < Kosmos::Package
  title 'CactEye Telescope'
  aliases 'cacteye'
  url 'https://app.box.com/s/89skim2e3simjwmuof4c'

  def install
    merge_directory 'GameData'
    merge_directory 'Ships'
  end
end
