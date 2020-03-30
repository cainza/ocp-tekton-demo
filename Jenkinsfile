def project_git_url = 'https://github.com/cainza/jenkins-ocp-java-pipeline-demo.git'
def service_name= 'pipelinesdemo'
def build_environment = "jenkins-cicd"
def deploy_environment = "jenkins-cicd"

node('maven') {

    properties([[$class: 'BuildDiscarderProperty', strategy: [$class: 'LogRotator', artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10']]]);

    stage('Cheking out Source Code'){
        git branch: 'master', changelog: false, poll: true, url: "${project_git_url}"
    }

    stage("Compiling & Running Unit Tests") {
            sh "mvn clean test package"
    }

    stage('Building Image') {
               sh "echo S2I Image build happens here"
               sh "mvn fabric8:build -Dfabric8.namespace=${build_environment}"

           }

           stage('Generate & Apply DeploymentConfig') {
               sh "echo Apply OpenShift resources"
               sh "mvn fabric8:resource fabric8:resource-apply -Dfabric8.namespace=${deploy_environment} -Dfabric8.generator.name=docker-registry.default.svc:5000/${build_environment}/${service_name}:latest"
           }

    stage('Deploy to Development') {
        sh "echo Deploy to ${deploy_environment} project"

        sh(script: "oc rollout latest dc/${service_name} -n ${deploy_environment}")
        sh(script: "oc rollout status dc/${service_name} -n ${deploy_environment} -w")

    }

}