package api

import (
	"database/sql"
	"math/rand"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	db "github.com/moslehazizi/Elyasam_Restaurant/db/sqlc"
)

type getServiceRequest struct {
	ID int64 `uri:"id" binding:"required,min=1"`
}

var discountOfferStruct []db.DiscountOffer

func (server *Server) getServiceById(c *gin.Context) {

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
	ServiceImage string `json:"service_image" binding:"required"`
	ServiceTitle string `json:"service_title" binding:"required"`
	Recipe       string `json:"recipe" binding:"required"`
	Price        int64  `json:"price" binding:"required"`
}

type postServiceRequestCategory struct {
	ID int64 `uri:"id" binding:"required,min=1"`
}

func (server *Server) postService(c *gin.Context) {
	var req postServiceRequest
	var reqC postServiceRequestCategory
	if err := c.ShouldBindUri(&reqC); err != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	arg := db.CreateServiceParams{
		ServiceImage:    req.ServiceImage,
		ServiceTitle:    req.ServiceTitle,
		ServiceCategory: reqC.ID,
		Recipe:          req.Recipe,
		Price:           req.Price,
	}

	service, err := server.store.CreateService(c, arg)

	if err != nil {
		c.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	c.JSON(http.StatusOK, service)
}

type postServiceRequestId struct {
	ID int64 `uri:"id" binding:"required,min=1"`
}

type updateServiceRequest struct {
	ServiceImage string `json:"service_image" binding:"required"`
	ServiceTitle string `json:"service_title" binding:"required"`
	Recipe       string `json:"recipe" binding:"required"`
	Price        int64  `json:"price" binding:"required"`
}

func (server *Server) putService(c *gin.Context) {
	var req postServiceRequestId
	var req_s updateServiceRequest
	if err_1 := c.ShouldBindUri(&req); err_1 != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err_1))
		return
	}
	if err_2 := c.ShouldBindJSON(&req_s); err_2 != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err_2))
		return
	}

	arg := db.UpdateServiceParams{
		ID:           req.ID,
		ServiceImage: req_s.ServiceImage,
		ServiceTitle: req_s.ServiceTitle,
		Recipe:       req_s.Recipe,
		Price:        req_s.Price,
	}

	service, err_3 := server.store.UpdateService(c, arg)

	if err_3 != nil {
		if err_3 == sql.ErrNoRows {
			c.JSON(http.StatusNotFound, errorResponse(err_3))
			return
		}
		c.JSON(http.StatusInternalServerError, errorResponse(err_3))
		return
	}

	c.JSON(http.StatusOK, service)
}

func (server *Server) getRandomServices(c *gin.Context) []db.DiscountOffer {

	// clean holder
	discountOfferStruct = nil

	// Get list of items in discount_offers
	arg := db.ListDiscountOffersParams{
		Limit:  20,
		Offset: 0,
	}
	discount_offers, err := server.store.ListDiscountOffers(c, arg)
	if err != nil {
		c.JSON(http.StatusInternalServerError, errorResponse(err))
	}

	discountOfferStruct = append(discountOfferStruct, discount_offers...)

	// Check if items in discountOfferStruct have been expired or not. it creates new list if data have been expired.
	if time.Now().Compare(discountOfferStruct[1].ExpiredAt) == 1 || time.Now().Compare(discountOfferStruct[1].ExpiredAt) == 0 {
		server.deleteDiscountOffers(c)
		server.makeListOfdiscounts(c)
		// c.JSON(http.StatusOK, gin.H{
		// 	"Discount offers": discountOfferStruct,
		// })
	} else if time.Now().Compare(discountOfferStruct[1].ExpiredAt) == -1 {
		// c.JSON(http.StatusOK, gin.H{
		// 	"Discount offers": discountOfferStruct,
		// })
	}
	return discountOfferStruct
}

// create new items for discountOfferStruct.
func (server *Server) makeListOfdiscounts(c *gin.Context) {

	arg := db.ListServicesByIdParams{
		Limit:  123,
		Offset: 0,
	}
	services_list, err := server.store.ListServicesById(c, arg)

	if err != nil {
		c.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	for i := 0; i < 20; i++ {
		rand.Seed(time.Now().UnixNano())
		randomIndex := rand.Intn(len(services_list))
		randomItem := services_list[randomIndex]
		discount_create_offer, err := server.store.CreateDiscountOffer(c, randomItem.ID)
		if err != nil {
			c.JSON(http.StatusInternalServerError, errorResponse(err))
			return
		}
		discountOfferStruct = append(discountOfferStruct, discount_create_offer)
	}
}

// Delete items on discountOfferStruct that expired
func (server *Server) deleteDiscountOffers(c *gin.Context) {
	for _, discountForDelte := range discountOfferStruct {
		err := server.store.DeleteDiscountOffer(c, discountForDelte.ID)
		if err != nil {
			if err == sql.ErrNoRows {
				c.JSON(http.StatusNotFound, errorResponse(err))
				return
			}
			c.JSON(http.StatusInternalServerError, errorResponse(err))
			return
		}
	}
}
