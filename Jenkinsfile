pipeline {
    agent any
    options {
        disableConcurrentBuilds()
    }
    stages {
        stage('Confirm for production') {
            when {
                beforeInput true
                branch 'master'
            }
            input {
                message "Build for production?"
            }            
            options {
                timeout(time: 30, unit: 'SECONDS')
            }
            steps {
                echo 'Confirmed'
            }
        }        
        stage('Build') {
            when {
                anyOf { branch 'master'; branch 'develop';  }
            }
            steps {
                sh '''
					if [ $BRANCH_NAME = "master" ]; then
						export IMAGE_TAG='prod';
						export DOCKER_REGISTRY=$PUB_DOCKER_REGISTRY
                    else
						export IMAGE_TAG='latest';
						export DOCKER_REGISTRY=$LOCAL_DOCKER_REGISTRY
					fi

					export IMAGE_NAMESPACE="bigdata"
					export IMAGE_NAME="flink120"
					export DOCKER_BUILD_DIR="."
					export DOCKERFILE_PATH="Dockerfile"

					chmod +x docker-build.sh && ./docker-build.sh
                '''
            }
        }
		stage('Deploy') {
            when {
                anyOf { branch 'master'; branch 'develop';  }
            }
            steps {
                sh '''
                    echo 'flink'
                '''
            }
        }
    }
	post {
		failure{
			qyWechatNotification mentionedId: '', mentionedMobile: '', moreInfo: '', webhookUrl: "${env.QYWX_WEBHOOK_URL}"
		}
	}
}