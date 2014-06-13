class AdvancedJetEngine < Kosmos::Package
  title 'Advanced Jet Engine'
  url 'https://www.dropbox.com/sh/v1funr72y504rz6/AACz3bnk0vM2-mY6IQY04jbfa/AJE_1.3.zip'

  def install
    merge_directory 'AJE', into: 'GameData'
  end
end

