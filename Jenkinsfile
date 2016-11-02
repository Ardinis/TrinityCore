node("docker"){
  deleteDir()
  checkout scm
  sh "docker build -t registry.benjy.lu/paragon/world-wotlk ."
  sh "docker push registry.benjy.lu/paragon/world-wotlk"
}
