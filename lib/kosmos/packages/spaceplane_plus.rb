class SpacePlanePlus < Kosmos::Package
  title 'Spaceplane Plus'
  url 'https://www.dropbox.com/s/xkaelclfjzzoicn/SpaceplanePlus.zip'

  def install
    merge_directory 'SpaceplanePlus v1.0.0/GameData'
    merge_directory 'SpaceplanePlus v1.0.0/Ships'
  end
end
