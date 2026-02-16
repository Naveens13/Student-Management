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
        stage('Build app & docker image') {
            environment{
                DOCKER_IMAGE = "naveen1531/student-management:${BUILD_NUMBER}"
            }
            steps {
                sh ''' 
                  mvn clean package
                  ls -la target/
                  docker build -t ${DOCKER_IMAGE} .
                '''
                script {
                    def dockerImage = docker.image("${DOCKER_IMAGE}")
                    docker.withRegistry('https://index.docker.io/v1/', "docker-cred") {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('DockerHub Push'){
        environment {
            GIT_REPO_NAME = "Student-Management"
            GIT_USER_NAME = "Naveens13"
        }
        steps {
            withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                sh '''
                    git config --global user.email "naveenbabu1531@gmail.com"
                    git config --global user.name "Naveen Babu"
                    # git config --global --add safe.directory $WORKSPACE
                    BUILD_NUMBER=${BUILD_NUMBER}
                    sed -i "s|image: naveen1531/student-management:.*|image: naveen1531/student-management:${BUILD_NUMBER}|g" Kubernetes_deployment/app_dplyt.yaml
                    git add student-management-deployment.yaml
                    git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                    git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                '''
            }
        }
        }
    }
}
