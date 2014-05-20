class EnvironmentalVisualEnhancementsHighRes < Kosmos::Package
  title 'Environmental Visual Enhancements - High Resolution'
  aliases 'environmental visual enhancements - high res',
          'environmental visual enhancements'

  url 'https://github.com/rbray89/EnvironmentalVisualEnhancements/releases/download/Release-7-3/EnvironmentalVisualEnhancements-7-3.zip'

  def install
    merge_directory 'GameData'
  end
end

class EnvironmentalVisualEnhancementsLowRes < Kosmos::Package
  title 'Environmental Visual Enhancements - Low Resolution'
  aliases 'environmental visual enhancements - low res'

  url 'https://github.com/rbray89/EnvironmentalVisualEnhancements/releases/download/Release-7-3LR/EnvironmentalVisualEnhancements-7-3-LR.zip'

  def install
    merge_directory 'GameData'
  end
end
