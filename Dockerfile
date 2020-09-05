FROM vedha/personal_r_build

MAINTAINER "Vedha Viyash" vedhaviyash4@gmail.com

# Copy the app to the image
COPY app.R /root/
WORKDIR /root/

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp(port = getOption('shiny.port', 3838), host = getOption('shiny.host', '0.0.0.0'))"]
