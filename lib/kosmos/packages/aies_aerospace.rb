class AIESAerospace < Kosmos::Package
  title 'AIES Aerospace'
  url 'http://www.mediafire.com/download/c8efj64k6izx6xc/AIES_Aerospace151.zip'

  def install
    merge_directory 'AIES_Aerospace', into: 'Parts'
  end
end

