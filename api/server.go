package api

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	db "github.com/moslehazizi/Elyasam_Restaurant/db/sqlc"
)

type Server struct {
	store  db.Store
	router *gin.Engine
}

var externalAPIResponse string
var externalAPIResponseJson map[string]interface{}

func NewServer(store db.Store) *Server {
	server := &Server{store: store}
	router := gin.Default()

	go func() {
		ticker := time.NewTicker(60 * time.Second)
		for {
			fmt.Println("Can you see this line?!")
			// Perform the REST API call and update externalAPIResponse

			updateGetServiceEveryMin()

			<-ticker.C

		}
	}()

	router.GET("/shop", server.getLanding)
	router.GET("/shop/detail/:id", server.getServiceById)

	router.POST("post/category", server.postCategory)
	router.POST("post/service/:id", server.postService)
	
	router.PUT("put/service/:id", server.putService)

	server.router = router
	return server
}

// Start run the HTTP server on a specific address
func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}

func updateGetServiceEveryMin() {
	response, err := http.Get("http://localhost:8080/shop/getRandomService")
	if err != nil {
		errorResponse(err)
		return
	}

	defer response.Body.Close()

	//Read the response body
	body, err := ioutil.ReadAll(response.Body)
	if err != nil {
		errorResponse(err)
		return
	}
	// Update the global variable with the response
	externalAPIResponse = string(body)
	json.Unmarshal([]byte(externalAPIResponse ), &externalAPIResponseJson)

}
