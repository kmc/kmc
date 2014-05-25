class SpacePlanePlus < Kosmos::Package
  title 'Spaceplane Plus'
  url 'https://dl.dropboxusercontent.com/s/xkaelclfjzzoicn/SpaceplanePlus.zip?dl=1&token_hash=AAHBFUzVJtrz_evWl2W3zLj0Q-KB02xNXGVM-bos8b-JRA&expiry=1400993355'

  def install
    merge_directory 'SpaceplanePlus v1.0.0/GameData'
    merge_directory 'SpaceplanePlus v1.0.0/Ships'
  end
end
