pipeline {
 try {
    def app
    agent {
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2'
        }
    }
    stage('Check SCM') {
            checkout scm
    }

    stage('Build') {
             app = docker.build("sanghvt/hello-world:${env.BUILD_NUMBER}", "-f Dockerfile .")
         }
         stage('Test') {
             steps {
                sh 'echo "Test"'
             }
         }
         stage('push image') {
             docker.withRegistry(''){
                 app.push()
             }
         }
         stage('helm delete repo chart on chartmuseum'){
             sh """
             curl -XDELETE http://localhost:8077/api/charts/hello-app/0.1.0
             helm repo update
             """
         }
         dir('k8s'){
             stage('helm push repo chart on Chartmuseum'){
                 sh """
                 helm push hello-app/ chartmuseum
                 helm repo update
                 helm search repo chartmuseum
                 """
             }
         }
         dir('k8s/hello-app'){
             stage('Deploy to helm') {
                sh 'pwd'
                sh """
                  echo "Build number in sh script: ${env.BUILD_NUMBER}"
                  helm upgrade hello-world chartmuseum/hello-app --set image.tag=${env.BUILD_NUMBER}
                """
                 }
    } catch (e) {
            currentBuild.result = "FAILED"
            throw e
        } finally {
            notifyBuild(currentBuild.result)
    }
}
