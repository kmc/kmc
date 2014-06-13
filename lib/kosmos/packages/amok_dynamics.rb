class AMOKDynamicsStuffA < Kosmos::Package
  title 'AMOK Dynamics'
  url 'https://www.dropbox.com/s/ijh3obajqti1h2g/AMOK%20FuelCell%20v0.1.zip'

  def install
    merge_directory 'AMOK FuelCell v0.1/GameData'
  end
end

