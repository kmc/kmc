class FASA < Kosmos::Package
  title 'FASA'
  url 'http://kerbal.curseforge.com/ksp-mods/220632-fasa'

  def install
    merge_directory 'GameData'
    merge_directory 'saves'
  end
end

class FASAGeminiAlternateIVA < Kosmos::Package
  title 'FASA Gemini Alternate IVA'
  url 'https://www.dropbox.com/s/kd657bp536dtw3x/MOARdV-FASAGemini-1.0.zip'

  def install
    merge_directory 'GameData'
  end
end
