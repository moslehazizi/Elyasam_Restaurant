package api

import (
	"net/http"

	"github.com/gin-gonic/gin"
	db "github.com/moslehazizi/Elyasam_Restaurant/db/sqlc"
)

type postCategoryRequest struct {
	CategoryTitle string `json:"category_title" binding:"required"`
	CategoryIcon  string `json:"category_icon" binding:"required"`
}

func (server *Server) postCategory(c *gin.Context) {
	var req postCategoryRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	arg := db.CreateCategoryParams{
		CategoryTitle: req.CategoryTitle,
		CategoryIcon: req.CategoryIcon,
	}
	category, err := server.store.CreateCategory(c, arg)

	if err != nil {
		c.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	c.JSON(http.StatusOK, category)
}