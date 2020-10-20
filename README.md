# Task 1 - Infrastructure Resources
I created main.tf file that holds my security groups, vpc, ec2, subnet and elb for this project, and also created a postgreSQL instance named postgreSQL.tf

# Task 2 - Application
Converted the node12 images from 1.7gb in size to 187mb by using docker multi-stage build

So, i added this line
from node12 AS base

# Task
# The Dockerfile for the api (todo-api) is inefficient. Convert it to a multi-stage docker build and make it as efficient/small as possible. If done correctly the final image should be < 300 MB.

step i took was going to use the docker documentation found in <https://docs.docker.com/develop/develop-images/multistage-build/>
Then added this line to the already existing docker file

from alpine # Most light weight image
COPY --from=base ./app ./ # this basicall copied an already existing file of the previous node12 image to the current directory, this will dratiscally reduce the image size 

step 3