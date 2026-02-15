pipeline {
    agent {
      docker {
        image 'naveen1531/maven-docker:v1'
        args '--user root -v /var/run/docker.sock:/var/run/docker.sock'
      }
    }

    stages {

        stage('Git Checkout verify') {
            steps {
              sh ''' 
                echo "Checkout SCM"
                ls -la
                pwd
                mvn --version
                java --version
                docker --version
              '''
            }
        }
        stage('Build') {
            steps {
                sh ''' 
                  mvn clean package
                  ls -la
                '''
            }
        }
    }
}
