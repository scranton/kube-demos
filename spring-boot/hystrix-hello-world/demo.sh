#!/bin/bash

. $(dirname ${BASH_SOURCE})/../../util.sh

desc "Getting a project from start.spring.io"
desc "spring init --name hystrix-hello-world --boot-version 1.3.7.RELEASE --groupId=com.example --artifactId=hystrix-hello-world --dependencies=web,actuator,cloud-hystrix --build=maven "
read -s
run "spring init --name hystrix-hello-world --boot-version 1.3.7.RELEASE --groupId=com.example --artifactId=hystrix-hello-world --dependencies=web,actuator,cloud-hystrix --build=maven --extract $(relative project/hystrix-hello-world)"


desc "We now have a project!"
run "cd $(relative project/hystrix-hello-world)"
run "ls -l "


desc "Let's add some functionality"
run "../../_impl-svc.sh"

desc "Open the project in your IDE if you'd like"
read -s

desc "Build and run the project; query the endpoint in a different screen: curl http://localhost:8080/api/hello/ceposta"
run "mvn spring-boot:run"

desc "I'll wait for you to fix the port stuff and run simple-hello-world"
read -s

desc "Try running again.."
run "mvn spring-boot:run"

desc "I'll wait for you to add the circuit breaker"
read -s

desc "Try running again.."
run "mvn spring-boot:run"

desc "Let's add the fabric8 magic!"
desc "mvn io.fabric8:fabric8-maven-plugin:LATEST:setup"
read -s
run "mvn io.fabric8:fabric8-maven-plugin:3.1.71:setup"
run "tail -n 30 pom.xml"

## We need to find out if minishift is running and stop it
#if [ $(minishift status) = "Running" ]; then
#    minishift stop;
#fi

#desc "Let's treat Kubernetes as an app server :)"
#run "mvn fabric8:cluster-start -Dfabric8.cluster.kind=openshift"

desc "Let's deploy our app!"
run "mvn fabric8:run"
