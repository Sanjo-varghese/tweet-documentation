## Build and Publish a Docker image 

1. Write and add dockerfile in the source code
	```sh
	FROM openjdk:8
	ADD jarstaging/com/sanjo/demo-workshop/2.1.2/demo-workshop-2.1.2.jar tweet-msg.jar
	ENTRYPOINT ["java", "-jar", "tweet-msg.jar"]
	```
   `Check-point:`  version number in pom.xml and dockerfile should match   
1. Create a docker repository in the Jfrog  
    repository name: sanjo-docker
1. Install `docker pipeline` plugin 

1. Update Jenkins file with the below stages  
    ```sh 
	   def imageName = 'sanjo1997.jfrog.io/sanjo-docker/tweet-msg'
	   def version   = '2.1.2'
        stage(" Docker Build ") {
          steps {
            script {
               echo '<--------------- Docker Build Started --------------->'
               app = docker.build(imageName+":"+version)
               echo '<--------------- Docker Build Ends --------------->'
            }
          }
        }

                stage (" Docker Publish "){
            steps {
                script {
                   echo '<--------------- Docker Publish Started --------------->'  
                    docker.withRegistry(registry, 'jfrog-cred'){
                        app.push()
                    }    
                   echo '<--------------- Docker Publish Ended --------------->'  
                }
            }
        }
    ```

Check-point: 
1. Provide jfrog repo URL in the place of `sanjo1997.jfrog.io/sanjo-docker` in `def imageName = 'sanjo1997.jfrog.io/sanjo-docker/tweet-msg'`  
2. Match version number in `def version   = '2.1.2'` with pom.xml version number  
3. Ensure you have updated credentials in the field of `artifactory_token` in `docker.withRegistry(registry, 'artifactory_token'){`

Note: make sure docker service is running on the slave system, and docker should have permissions to /var/run/docker.sock

check and Run Docker on Maven Slave
```sh
docker images
docker run -dt --name tweet-msg -p 8000:8000 sanjo1997.jfrog.io/sanjo-docker-local/tweet-msg:2.1.2
on Browser <maven-slave-public-ip>:8080 port
```
