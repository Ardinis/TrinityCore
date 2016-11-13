node("docker"){
  deleteDir()
  checkout scm
  sh "docker build -t registry.psadmin.eu/paragon/world-wotlk ."
  sh "docker push registry.psadmin.eu/paragon/world-wotlk"
  sh "docker rmi registry.psadmin.eu/paragon/world-wotlk"
}
