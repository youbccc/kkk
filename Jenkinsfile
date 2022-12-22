pipeline {
  agent none

  stages {
    stage('Checkout') {
      agent any
      steps {
        git branch: 'main', url: 'https://github.com/youbccc/kkk.git'
      }
    }
    stage('Build') {
      agent {
        docker { image 'maven:3-openjdk-8' }
      }
      steps {
        sh 'mvn clean package -DskipTests=true'
      }
    }
    stage('Test') {
      agent {
        docker { image 'maven:3-openjdk-8' }
      }
      steps {
        sh 'mvn test'
      }
    }
    stage('Build Docker Image') {
      agent any
      steps {
        sh 'docker image build -t youbccc/kkk:latest .'
      }
    }
    stage('Tag Docker Image') {
      agent any
      steps {
        sh 'docker image tag youbccc/kkk:latest youbcc/kkk:$BUILD_NUMBER'
      }
    }
    stage('Publish Docker Image') {
      agent any
      steps {
        withDockerRegistry(credentialsId: 'docker-hub-token', url: 'https://index.docker.io/v1/') {
          sh 'docker push youbccc/kkk:$BUILD_NUMBER'
          sh 'docker push youbccc/kkk:latest'
         }
      }
    }
    stage('Run Docker Container') {
      agent {
        docker { image 'docker:dind' }
      }
      steps {
        sh 'docker -H tcp://192.168.56.11:80 container run --detach --name webserver -p 80:8080 youbc/kkk:$BUILD_NUMBER'
      }
    }
  }
}
