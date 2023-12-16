package api

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type postSliderImageRequest struct {
	ImagePath string `json:"image_path" binding:"required"`
}

func (server *Server) postSliderImage(c *gin.Context) {
	var req postSliderImageRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	slider_image, err := server.store.CreateSliderImage(c, req.ImagePath)

	if err != nil {
		c.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	c.JSON(http.StatusOK, slider_image)
}
