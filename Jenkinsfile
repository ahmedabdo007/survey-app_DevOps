pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('docker-hub-repo')
	}

	stages {

		stage('Build') {

			steps {
				sh 'docker build -t ahmedabdoahmed/survey-app-img:1.1 .'
			}
		}

		stage('Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}


		stage('Push') {

			steps {
				sh 'docker push ahmedabdoahmed/survey-app-img:1.1'
			}
		}
        stage('deploy') {
            steps {
                script {
                   sshagent(['ec2-server-key']) {

				
					def dockerCmd = 'docker run  -p 8081:80 -d  ahmedabdoahmed/survey-app-img:1.1'

						sh "ssh -o StrictHostKeyChecking=no ubuntu@ec2-3-89-246-92.compute-1.amazonaws.com ${dockerCmd}"

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
