class UniversalStorage < Kosmos::Package
  title 'Universal Storage'
  url 'http://www.kingtiger.co.uk/kingtiger/wordpress/?smd_process_download=1&download_id=1478'
  prerequisites 'module-manager'

  def install
    merge_directory 'US_Core', into: 'GameData'
  end
end

class UniversalStorageKAS < Kosmos::Package
  title 'Universal Storage - Kerbal Attachment System'
  aliases 'Universal Storage - KAS'
  url 'http://www.kingtiger.co.uk/kingtiger/wordpress/?smd_process_download=1&download_id=1544'
  prerequisites 'kerbal-attachment-system', 'universal-storage'

  def install
    merge_directory 'US_KAS', into: 'GameData'
  end
end

class UniversalStorageECLSS < Kosmos::Package
  title 'Universal Storage - ECLSS Life Support'
  aliases 'Universal Storage - ECLSS'
  url 'http://www.kingtiger.co.uk/kingtiger/wordpress/?smd_process_download=1&download_id=1480'
  prerequisites 'eclss-life-support', 'universal-storage'

  def install
    merge_directory 'US_ECLSS', into: 'GameData'
  end
end

class UniversalStoragePartCatalog < Kosmos::Package
  title 'Universal Storage - Part Catalog'
  url 'http://www.kingtiger.co.uk/kingtiger/wordpress/?smd_process_download=1&download_id=1482'
  prerequisites 'part-catalog', 'universal-storage'

  def install
    merge_directory 'PartCatalog/Plugins/PluginData/PartCatalog/UniversalStorage_Off.png', into: 'GameData/PartCatalog/Plugins/PluginData/PartCatalog/Icons/Mods'
    merge_directory 'PartCatalog/Plugins/PluginData/PartCatalog/UniversalStorage_On.png', into: 'GameData/PartCatalog/Plugins/PluginData/PartCatalog/Icons/Mods'
  end
end