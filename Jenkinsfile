node("docker"){
  deleteDir()
  checkout scm
  sh "docker login registry.build.lu -u jenkins -p jenkins"
  sh "docker build -t registry.benjy.lu/paragon/world-wotlk ."
  sh "docker push registry.benjy.lu/paragon/world-wotlk"
}
