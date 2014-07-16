class B9IVAExtension < Kosmos::Package
  title 'B9 IVA Extension'
  aliases 'B9 crew tank internals'
  
  url 'http://www.mediafire.com/download/x64zpyd65toepcc/B9_IVA_Extension_0.5.1.zip'

  def install
    merge_directory 'GameData'
  end
end

