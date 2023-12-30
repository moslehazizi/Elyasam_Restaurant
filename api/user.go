package api

import (
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/lib/pq"
	db "github.com/moslehazizi/Elyasam_Restaurant/db/sqlc"
	"github.com/moslehazizi/Elyasam_Restaurant/util"
)

type createUserRequest struct {
	PhoneNumber string `json:"phone_number" binding:"required"`
	Password    string `json:"hashed_password" binding:"required,min=6"`
	FirstName   string `json:"first_name" binding:"required"`
	LastName    string `json:"last_name" binding:"required"`
	Email       string `json:"email" binding:"required,email"`
}

type createUserResponse struct {
	PhoneNumber    string    `json:"phone_number"`
	FirstName      string    `json:"first_name"`
	LastName       string    `json:"last_name"`
	Email          string    `json:"email"`
	CreatedAt      time.Time `json:"created_at"`
}

func (server *Server) createUser(c *gin.Context) {
	var req createUserRequest
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, errorResponse(err))
		return
	}

	hashedPassword, err := util.HashPassword(req.Password)

	if err != nil {
		c.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	arg := db.CreateUserParams{
		PhoneNumber:    req.PhoneNumber,
		HashedPassword: hashedPassword,
		FirstName:      req.FirstName,
		LastName:       req.LastName,
		Email:          req.Email,
	}

	user, err := server.store.CreateUser(c, arg)

	if err != nil {
		if pqErr, ok := err.(*pq.Error); ok {
			switch pqErr.Code.Name() {
			case "unique_violation":
				c.JSON(http.StatusForbidden, errorResponse(err))
				return
			}
		}
		c.JSON(http.StatusInternalServerError, errorResponse(err))
		return
	}

	res := createUserResponse {
		PhoneNumber: user.PhoneNumber,
		FirstName: user.FirstName,
		LastName: user.LastName,
		Email: user.Email,
	}

	c.JSON(http.StatusOK, gin.H{
		"response": res})
}

// type getUserRequest struct {
// 	phoneNumber string `json:"phone_number" binding:"required"`
// 	password string `json:"hashed_password" binding:"required"`
// }

// func (server *Server) getUser(c *gin.Context) {
// 	var req getUserRequest
// 	if err := c.ShouldBindJSON(&req); err != nil {
// 		c.JSON(http.StatusBadRequest, errorResponse(err))
// 		return
// 	}

// 	hashedPassword, err := util.HashPassword(req.password)

// 	if err != nil {
// 		c.JSON(http.StatusNotFound, errorResponse(err))
// 		return
// 	}

// 	arg := db.GetUserParams {
// 		PhoneNumber: req.phoneNumber,
// 		HashedPassword: req.password,
// 	}

// 	user, err := server.store.GetUser(c, arg)
// 	if err != nil {
// 		if err == sql.ErrNoRows {
// 			c.JSON(http.StatusNotFound, errorResponse(err))
// 			return
// 		}
// 		c.JSON(http.StatusInternalServerError, errorResponse(err))
// 		return
// 	}
// 	c.JSON(http.StatusOK, user)
// }
