class CargoTransferBags < Kosmos::Package
  title 'Cargo Transfer Bags'
  url 'http://www.mediafire.com/download/eucjkl11bkndmjd/CargoTransferBags0.7.zip'

  def install
    merge_directory 'CargoTransferBags', into: 'GameData'
  end
end

