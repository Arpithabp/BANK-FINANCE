pipeline {
    agent any

    tools {
        maven "maven"
    }

    stages {
        stage('Git checkout') {
            steps {
              
                   git 'https://github.com/SaiRevanth-J/project-02-bank-finacial.git'
            
                }
            }
        stage('maven build') {
              steps {
              
                     sh "mvn install package"
                }
        }
        
        stage('Publish HTML') {
              steps {
              
                    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/project_k/target/surefire-reports/', reportFiles: 'index.html', reportName: 'project_k-HTML Report', reportTitles: '', useWrapperFileDirectly: true])
                }
        }
        
          stage('Docker build image') {
              steps {
                  
                  sh'sudo docker system prune -af '
                  sh 'sudo docker build -t revanthkumar9/bank-finance:${BUILD_NUMBER}.0 .'
              
                }
            }
                
        stage('Docker login and push') {
              steps {
                   withCredentials([string(credentialsId: 'docpass', variable: 'docpasswd')]) {
                  sh 'sudo docker login -u revanthkumar9 -p ${docpasswd} '
                  sh 'sudo docker push revanthkumar9/bank-finance:${BUILD_NUMBER}.0 '
                  }
                }
        }    
                
        stage (' configuring Test-server with terraform & ansible and deploying'){
            steps{

                dir('test-server'){
                sh 'sudo chmod 600 DEMOKEY'
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply --auto-approve'
                }
               
            }
        }
       
       /* stage('Selenium test') {
              steps {
                  
                  sh 'cd ..'
                  sh 'java -jar seleniumtest.jar'
                  sh"echo 'app tested succussfully' "
                           
                }
            }
          
         stage ('setting Test-server with terraform'){
            steps{
                sh 'cd prod-server'
                sh 'chmod 600 DEMOKEY.pem'
                sh'terraform init'
                sh'terraform validate'
                sh'terraform apply --auto-approve'
            }
        }

         stage('Deploy the Application in Prod-server') {
              steps {
                  
                  sh 'ansible-playbook prod-bank-playbook.yml'
                  sh" ansible prod-server -b -m shell -a 'sudo docker run -id -p 7000:8081 --name banking${BUILD_NUMBER} revanthkumar9/bank-finance:${BUILD_NUMBER}.0' "
              
                }
            }*/
        
    }
}
