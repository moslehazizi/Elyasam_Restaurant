package api

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
	db "github.com/moslehazizi/Elyasam_Restaurant/db/sqlc"
	"github.com/moslehazizi/Elyasam_Restaurant/token"
	"github.com/moslehazizi/Elyasam_Restaurant/util"
)

type Server struct {
	store      db.Store
	tokenMaker token.Maker
	router     *gin.Engine
	config     util.Config
}

var externalAPIResponse string
var externalAPIResponseJson map[string]interface{}

func NewServer(config util.Config, store db.Store) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TokenSymmetricKey)
	if err != nil {
		return nil, fmt.Errorf("cannot create token maker: %w", err)
	}

	server := &Server{
		config:     config,
		store:      store,
		tokenMaker: tokenMaker,
	}
	
	server.setupRouter()
	return server, nil
}

func (server *Server) setupRouter() {
	router := gin.Default()

	router.Use(corsMiddleware())

	router.GET("/shop", server.getLanding)
	router.GET("/shop/detail/:id", server.getServiceById)

	router.POST("post/category", server.postCategory)
	router.POST("post/service/:id", server.postService)
	router.POST("post/sliderImage", server.postSliderImage)
	router.POST("post/discountOffer", server.PostDiscountOffer)

	router.POST("post/user", server.createUser)
	router.POST("post/user/login", server.loginUser)

	router.PUT("put/service/:id", server.putService)

	server.router = router
}

// Start run the HTTP server on a specific address
func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}

// corsMiddleware is a middleware function to enable CORS
func corsMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		c.Writer.Header().Set("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(http.StatusNoContent)
			return
		}

		c.Next()
	}
}
