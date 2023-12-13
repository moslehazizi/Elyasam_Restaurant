package api

import (
	"database/sql"
	"net/http"

	"github.com/gin-gonic/gin"
	db "github.com/moslehazizi/Elyasam_Restaurant/db/sqlc"
)

type getServiceRequest struct {
	ID int64 `uri:"id" binding:"required,min=1"`
}

func (server *Server) getSeerviceById(c *gin.Context) {

	var req getServiceRequest
	if err := c.ShouldBindUri(&req); err != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	service, err := server.store.GetService(c, req.ID)
	if err != nil {
		if err == sql.ErrNoRows {
			c.JSON(http.StatusNotFound, errorResponse(err))
			return
		}
		c.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}
	c.JSON(http.StatusOK, service)

}

type postServiceRequest struct {
	ServiceImage    string `json:"service_image" binding:"required"`
	ServiceTitle    string `json:"service_title" binding:"required"`
	ServiceCategory int64  `json:"service_category" binding:"required"`
	Recipe          string `json:"recipe" binding:"required"`
	Price           int64  `json:"price" binding:"required"`
}

func (server *Server) postService (c *gin.Context) {
	var req postServiceRequest
	arg := db.CreateServiceParams{
		ServiceImage: req.ServiceImage,
		ServiceTitle: req.ServiceTitle,
		ServiceCategory: req.ServiceCategory,
		Recipe: req.Recipe,
		Price: req.Price,
	}

	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}
	service, err := server.store.CreateService(c, arg)

	if err != nil {
		c.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	c.JSON(http.StatusOK, service)
}
