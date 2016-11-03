node("docker"){
  deleteDir()
  checkout scm
  sh "docker login registry.benjy.lu -u jenkins -p jenkins"
  sh "docker build -t registry.benjy.lu/paragon/world-wotlk ."
  sh "docker push registry.benjy.lu/paragon/world-wotlk"
  sh "docker rmi registry.benjy.lu/paragon/world-wotlk"
}
