pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('docker-hub-repo')
	}

	stages {



		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}
		stage('Build') {

			steps {
				sh 'ansible-playbook playbook.yml'
			}
		}
		
        stage('deploy') {
            steps {
                script {
                   sshagent(['ec2-server-key']) {
					def dockerCmd = 'docker run  -p 8081:80 -d  ahmedabdoahmed/cv-website:1.3'
						sh "ssh -o StrictHostKeyChecking=no ubuntu@ec2-3-73-53-138.eu-central-1.compute.amazonaws.com ${dockerCmd}"
					}
                }
            }
        }
	}

	post {
		always {
			sh 'docker logout'
		}
	}

}