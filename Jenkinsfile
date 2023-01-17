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
					def shellCmd = 'bash ./install.sh'
						sh "scp install.sh ubuntu@ec2-3-89-246-92.compute-1.amazonaws.com:/home/ubuntu"
						sh "ssh -o StrictHostKeyChecking=no ubuntu@ec2-3-89-246-92.compute-1.amazonaws.com ${shellCmd}"
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
