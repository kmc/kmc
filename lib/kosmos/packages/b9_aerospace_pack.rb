class B9AerospacePack < Kosmos::Package
  title 'B9 Aerospace Pack'
  aliases 'b9', 'b9 aerospace'

  url 'http://kerbalspaceport.com/wp/wp-content/themes/kerbal/inc/download.php?f=uploads/2013/10/B9-Aerospace-Pack-R4-0c.zip'

  def install
    merge_directory 'GameData'
    merge_directory 'Ships'
  end
end

class B9Aerospace0235Fix < Kosmos::Package
  title 'B9 Aerospace Pack - Fix for KSP 0.23.5'
  aliases 'b9 fix', 'b9 0.23.5 fix'

  url 'https://dl.dropboxusercontent.com/s/8bjgxv65yshg2z3/B9%20KSP%200.23.5.zip?dl=1&token_hash=AAGfJoLGv1B-uMOrI2EFx7B17PeMXAn_2xxeXbsyfJAm_A&expiry=1400451641'

  def install
    merge_directory 'B9 KSP 0.23.5/GameData'
  end
end
