package api

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

type postDiscountOfferReq struct {
	ServiceID int64 `json:"service_id" binding:"required"`
}

func (server *Server) PostDiscountOffer(c *gin.Context) {
	var req postDiscountOfferReq
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	discount_offer, err_1 := server.store.CreateDiscountOffer(c, req.ServiceID)

	if err_1 != nil {
		c.JSON(http.StatusInternalServerError, errorResponse(err_1))
		return
	}

	c.JSON(http.StatusOK, discount_offer)
}
