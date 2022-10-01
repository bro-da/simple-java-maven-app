pipeline {
    agent any
    def app 
    
     environment {
        DATE = new Date().format('yy.M')
        TAG = "${DATE}.${BUILD_NUMBER}"
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
        // stage('Docker') {
        //     steps {
        //         script {
        //         sh 'docker build -t maven-sample .'
        //         sh 'docker images'
        //         }
        //      }
        //     }
        // stage('Docker Build') {
        //     steps {
        //         script {
        //             docker.build("vivans/sample-build:${TAG}")
        //         }
        //     }
        // }
    
            
           
      stage('Build image') {         
       
            app = docker.build("vivans/sample-build")    
       }
       stage('Test image') {           
            app.inside {            
             
             sh 'echo "Tests passed"'        
            }    
        }     
        stage('Push image') {
                                                  docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_id') {            
       app.push("${env.BUILD_NUMBER}")            
       app.push("latest")        
              }    
           }
    
    }
}