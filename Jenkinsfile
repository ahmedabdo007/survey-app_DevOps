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

				
					def dockerCmd = 'docker run -d --name django-container -p 4000:8000 ahmedabdoahmed/survey-app-img'

						sh "ssh -o StrictHostKeyChecking=no ubuntu@ec2-54-210-59-22.compute-1.amazonaws.com ${dockerCmd}"

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
