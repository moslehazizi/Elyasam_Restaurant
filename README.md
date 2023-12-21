Elyasam_Restarant

This is back-end RESTful api service for a restaurant. The website's purpose is to introduce menu and services of the restaurant, and also authenticate clients and get order from them.

Setup

First clone the repo:

  $ git clone https://github.com/moslehazizi/Elyasam_Restaurant.git
	
  $ cd Elyasam_Restaurant

Ensure docker-compose is installed on your build system. For details on how to do this, see: https://docs.docker.com/compose/install/

Run project with:

  $ docker compose up

Now open new tab in terminal and use backup db file for test the program:

  $ make restore

You can browse program by make request with any API platform like Postman, Thunder client on VSC and etc on your local system with port 8080.

Landing page api: localhost:8080/shop

Detail service api: localhost:8080/shop/detail/:id
