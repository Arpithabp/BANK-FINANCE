pipeline {
    agent any

    tools {
         maven 'M2_HOME'
    }

    stages {
        stage('Git checkout') {
            steps {
              
                   git 'https://github.com/Arpithabp/BANK-FINANCE.git'
            
                }
            }
        stage('maven build') {
              steps {
              
                     sh "mvn install package"
                }
        }
        
        stage('Publish HTML') {
              steps {
                    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/project-02-banking/target/surefire-reports', reportFiles: 'index.html', reportName: 'project-02-HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                }
        }
        
          stage('Docker build image') {
              steps {
                  
                  sh'sudo docker system prune -af '
                  sh 'sudo docker build -t arpithabp/banking-finance:${BUILD_NUMBER}.0 .'
              
                }
            }
                
        stage('Docker login and push') {
              steps {
                   withCredentials([string(credentialsId: 'Docker-Hub', variable: 'dockerHubPassword')]) {
                  sh 'sudo docker login -u arpithabp -p ${docpasswd} '
                  sh 'sudo docker push arpithabp/banking-finance:${BUILD_NUMBER}.0 '
                  }
                }
        }    
             
    }
}
