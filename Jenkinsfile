node {
     stage('Clone repository') {
         checkout scm
     }
     stage('Build image') {
         app = docker.build("youbc/kkk")
     }
     stage('Push image') {
         docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
             app.push("$BUILD_NUMBER")
	     app.push("latest")
         }
     }
     
}
