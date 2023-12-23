package api

import (
	"net/http"

	"github.com/gin-gonic/gin"
	db "github.com/moslehazizi/Elyasam_Restaurant/db/sqlc"
)

func (server *Server) getLanding(c *gin.Context) {

	var responseCategories []db.Category
	var responseServices []db.Service
	var responseSlider []db.SliderImage

	arg := db.ListCategoriesParams{
		Limit:  19,
		Offset: 0,
	}
	categories, err_1 := server.store.ListCategories(c, arg)
	if err_1 != nil {
		c.JSON(http.StatusInternalServerError, errorResponse(err_1))
		return
	}

	responseCategories = append(responseCategories, categories...)

	for _, category := range categories {
		arg := db.ListServicesParams{
			ServiceCategory: category.ID,
			Limit:           20,
			Offset:          0,
		}
		var err error
		services_for_category, err := server.store.ListServices(c, arg)
		if err != nil {
			c.JSON(http.StatusInternalServerError, errorResponse(err))
			return
		}
		responseServices = append(responseServices, services_for_category...)
		// c.JSON(http.StatusOK, gin.H{
		// 	fmt.Sprintf("Services for category number %d", arg.ServiceCategory): services_for_category})
	}

	arg_2 := db.ListSliderImagesParams{
		Limit:  5,
		Offset: 0,
	}

	slider_images, err := server.store.ListSliderImages(c, arg_2)
	if err != nil {
		c.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	responseSlider = append(responseSlider, slider_images...)

	// c.JSON(http.StatusOK, gin.H{
	// 	"categories": categories})

	// c.JSON(http.StatusOK, gin.H{
	// 	"Slider images": slider_images})
	// server.getRandomServices(c)

	c.JSON(http.StatusOK, gin.H{
		"categories": responseCategories,
		"servicesForCategories": responseServices,
		"sliderImages": responseSlider,
		"discountOffers": server.getRandomServices(c),
	})
}
