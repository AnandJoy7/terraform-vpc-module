pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
    }

    stages {
        stage('Checkout Code from GitHub') {
            steps {
                git branch: 'main', url: 'https://github.com/AnandJoy7/terraform-vpc-module.git'
            }
        }

        stage('Set Up Python Environment') {
            steps {
                // Install Python if necessary, e.g.:
                // sh 'sudo apt-get install python3 python3-pip'
                sh 'pip install -r requirements.txt'  // If you have any dependencies
            }
        }

        stage('Run Terraform Script') {
            steps {
                sh 'python3 terraform_script.py'
            }
        }
    }

    post {
        success {
            echo "Terraform applied successfully!"
        }
        failure {
            echo "Pipeline failed. Check the logs for more details."
        }
    }
}
