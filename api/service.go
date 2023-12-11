package api

import (
	"database/sql"
	"net/http"

	"github.com/gin-gonic/gin"
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
