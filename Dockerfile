FROM 		ubuntu
MAINTAINER	Mikael Larsson "mikael.larsson@romram.se"

# Add and update apt sources
RUN apt-get update; apt-get -y upgrade

# Add compiler package and ruby1.9.1
RUN apt-get install -y build-essential ruby1.9.1-dev
RUN apt-get install -y nodejs

# Install dashing and bundle
RUN gem install dashing --no-rdoc --no-ri
RUN gem install bundle --no-rdoc --no-ri

# Default command that autostarts the dashing project
CMD ["bash", "/dashboard/start.sh"]
