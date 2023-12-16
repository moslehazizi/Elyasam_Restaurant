package api

import (
	"github.com/gin-gonic/gin"
	db "github.com/moslehazizi/Elyasam_Restaurant/db/sqlc"
)

type Server struct {
	store  db.Store
	router *gin.Engine
}

func NewServer(store db.Store) *Server {
	server := &Server{store: store}
	router := gin.Default()

	router.GET("/shop", server.getLanding)
	router.GET("/shop/detail/:id", server.getSeerviceById)

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
