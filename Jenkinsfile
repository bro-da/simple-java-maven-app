pipeline {
    agent any
    
     environment {
        DATE = new Date().format('yy.M')
        TAG = "${DATE}.${BUILD_NUMBER}"
        DOCKERHUB_CREDENTIALS=credentials('dockerhub')
    }
    options {
        skipStagesAfterUnstable()
    }
   
    stages {
         stage('Cloning Git') {
      steps {
        git([url: 'https://github.com/bro-da/simple-java-maven-app.git'])
 
      }
    }
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Deliver') { 
            steps {
                sh './jenkins/scripts/deliver.sh' 
            }
        }
        stage('Docker') {
            steps {
                script {
                // sh 'docker rmi maven-sample'
                sh 'docker build -t vivans/sample .'
                sh 'docker images'
                }
             }
            }
            stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}
        stage('Push') {
            docker.withRegistry('https://registry.hub.docker.com')
			steps {
                
				sh 'docker push vivans/sample-build:$TAG'
			}
		}
	}

	post {
		always {
			sh 'docker logout'
		}
	}
        // stage('Docker Build') {
        //     steps {
        //         script {
        //             docker.build("vivans/sample-build:${TAG}")
        //         }
        //     }
        // }

    }
    
