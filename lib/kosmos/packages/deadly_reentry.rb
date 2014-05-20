class DeadlyReentry < Kosmos::Package
  title 'Deadly Reentry'
  url 'https://github.com/NathanKell/DeadlyReentry/releases/download/v4.7/DeadlyReentryCont_v4.7.zip'

  def install
    merge_directory 'DeadlyReentry', into: 'GameData'
    merge_directory 'ModuleManager.2.1.0.dll', into: 'GameData'
  end
end
