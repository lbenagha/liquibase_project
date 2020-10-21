# Task 1 - Infrastructure Resources
I created main.tf file that holds my security groups, vpc, ec2, subnet and elb for this project, and also created a postgreSQL instance named postgreSQL.tf

# Task 2 - Application
Converted the node12 images from 1.7gb in size to 187mb by using docker multi-stage build

So, i added this line
from node12 AS base

# Task 2 
# The Dockerfile for the api (todo-api) is inefficient. Convert it to a multi-stage docker build and make it as efficient/small as possible. If done correctly the final image should be < 300 MB.

step i took was going to use the docker documentation found in <https://docs.docker.com/develop/develop-images/multistage-build/>
Then added this line to the already existing docker file

from alpine # Most light weight image
COPY --from=base ./app ./ # this basicall copied an already existing file of the previous node12 image to the current directory, this will dratiscally reduce the image size 

# Task 2
# The docker-compose file in the root of the project has 2 bugs. Fix them. You should be able to run a docker-compose up to start the application. If the application is working you should be able to browse to http://localhost and create a to-do list.

trying to run docker-compose up but running into this error below
$ docker-compose up docker-compose.yml
ERROR: Named volume "db\postgres-init.sql:/docker-entrypoint-initdb.d/postgres-init.sql:rw" is used in service "db" but no declaration was found in the volumes section.

I'm adding a . to the " ./db\postgres-init.sql:/docker-entrypoint-initdb.d/postgres-init.sql:rw"
it returned an error message- 
$ docker-compose up docker-compose.yml 
Creating network "sre_homework_backend" with the default driver
Creating network "sre_homework_frontend" with the default driver
ERROR: No such service: docker-compose.yml

After this error message i added to the api what we discussed yesterday <-db_host_name=db>, so that it treats it as a volume not the original db from the container
But it didnt work i retunred another error message

lbena@DESKTOP-CJ527D1 MINGW64 ~/Documents/github/sre_homework (master)
$ docker-compose up docker-compose.yml 
ERROR: Service 'api' depends on service 'db_host_name=db' which is undefined.

# Now where i'm stucked at is this
# my question is how do i kind of work arround this problem?, made some research but not seeing any solutions out there yet






