package api

import (
	"net/http"

	"github.com/gin-gonic/gin"

)

type postSliderImageRequest struct {
	ImagePath string `json:"image_path" binding:"required"`
}

func (server *Server) postSliderImage (c *gin.Context) {
	var req postSliderImageRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

}