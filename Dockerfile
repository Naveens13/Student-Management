# Step 1: Use an official Java runtime as the base image
FROM maven:3.9.6-eclipse-temurin-17

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the JAR file from the target folder to the working directory
COPY target/Student-Management-0.0.1-SNAPSHOT.jar Student-Management-0.0.1-SNAPSHOT.jar

# Step 4: Expose the port your application will run on
EXPOSE 8080

# Step 5: Specify the command to run the application
ENTRYPOINT ["java", "-jar", "Student-Management-0.0.1-SNAPSHOT.jar"]
