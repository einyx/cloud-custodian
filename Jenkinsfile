#!groovy

pipeline {
    options { buildDiscarder(logRotator(numToKeepStr: '5')) }
    agent {
        kubernetes {
            label 'custodian-builder'
            defaultContainer 'jnlp'
            yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    app: custodian-builder
  annotations:
    iam.amazonaws.com/role: jenkins
spec:
  containers:
  - name: docker
    image: einyx/custodian
    command:
    - cat
    tty: true
"""
        }
    }
    stages {
        stage('Validating policy') {
            steps {
                container('docker') {
                   sh "custodian validate policies/custodian.yml"
                }
            }
        }

        stage('Applying policies') {
          steps {
            timeout(time: 3, unit: 'MINUTES') {
              retry(5) {
                container('docker') {
                  sh 'custodian run --output-dir=./logs policies/custodian.yml'
                  sh 'printenv'
                }
              }
            }
         }
     }
  }
}


def getCommitSha() {
  return sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
}

def getBranchName() {
    if (!env.BRANCH_NAME) {
         return sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
    }
    return env.BRANCH_NAME
}

def kubectlTest() {
    // Test that kubectl can correctly communication with the Kubernetes API
    echo "running kubectl test"
    sh "kubectl get nodes"

}

