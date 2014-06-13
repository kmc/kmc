class GimbalAutoTrim < Kosmos::Package
  title 'Gimbal Auto Trim'
  url 'https://ksp.sarbian.com/jenkins/job/GimbalAutoTrim/2/artifact/jenkins-GimbalAutoTrim-2/GimbalAutoTrim-1.0.0.0.zip'

  def install
    merge_directory 'GimbalAutoTrim', into: 'GameData'
  end
end

