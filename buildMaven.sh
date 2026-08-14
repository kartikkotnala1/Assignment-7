#!/bin/bash

case "$1" in

    -a)
        echo "Generating artifact..."
        mvn clean package
        ;;

    -i)
        echo "Installing artifact to local repository..."
        mvn clean install
        ;;

    -s)
        case "$2" in

            checkstyle)
                echo "Running Checkstyle..."
                mvn checkstyle:check
                ;;

            findbugs)
                echo "Running FindBugs..."
                mvn findbugs:findbugs
                ;;

            pmd)
                echo "Running PMD..."
                mvn pmd:pmd
                ;;
        esac
        ;;

    -t)
        echo "Running unit tests..."
        mvn test
        ;;

    -d)
        echo "Generating artifact..."
        mvn clean package

        echo "Deploying WAR to Tomcat..."

        WAR_FILE=$(find target -maxdepth 1 -name "*.war" | head -n 1)

        if [ -z "$WAR_FILE" ]; then
            echo "WAR file not found!"
            exit 1
        fi

        sudo cp "$WAR_FILE" /opt/tomcat/apache-tomcat-9.0.120/webapps/

        echo "Deployment completed."
        ;;

esac or yeh 7 h
