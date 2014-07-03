class ImprovedChaseCamera < Kosmos::Package
  title 'Improved Chase Camera'
  url 'https://dl.dropboxusercontent.com/u/103148235/ImprovedChaseCamerav1.3.1.zip'

  def install
   merge_directory 'ImprovedChaseCamera', into: 'GameData'
  end
end
