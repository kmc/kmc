class ProceduralWing < Kosmos::Package
  title 'Procedural Wing'
  aliases 'Procedural Wings'
  url 'https://dl.dropboxusercontent.com/u/70818657/ProceduralDynamics0.7.zip'

  def install
    merge_directory 'ProceduralDynamics', into: 'GameData'
  end
end

